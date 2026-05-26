<template>
    <div class="questions-container">
        <div class="header-container">
            <div class="section-title">题库管理</div>
        </div>

        <!-- 搜索筛选栏 -->
        <div class="search-container">
            <div class="search-box">
                <input type="text" v-model="searchKeyword" placeholder="搜索题目内容" class="search-input">
                <select v-model="searchType" class="type-select">
                    <option value="">全部题型</option>
                    <option value="single">单选题</option>
                    <option value="multiple">多选题</option>
                    <option value="judge">判断题</option>
                    <option value="fill">填空题</option>
                    <option value="essay">简答题</option>
                </select>
                <select v-model="searchDifficulty" class="difficulty-select">
                    <option value="">全部难度</option>
                    <option value="1">⭐ 简单</option>
                    <option value="2">⭐⭐ 中等</option>
                    <option value="3">⭐⭐⭐ 困难</option>
                </select>
                <button class="search-btn" @click="handleSearch">🔍 搜索</button>
                <button class="reset-btn" @click="resetSearch">重置</button>
            </div>
        </div>

        <!-- 题目列表表格 -->
        <div class="table-container">
            <table class="data-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>题型</th>
                        <th>题目内容</th>
                        <th>难度</th>
                        <th>分值</th>
                        <th>创建时间</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <tr v-for="question in questionsArr" :key="question.question_id">
                        <td>{{ question.question_id }}</td>
                        <td><span class="badge" :class="typeClassMap[question.type]">{{ typeNameMap[question.type] }}</span></td>
                        <td class="question-content">{{ question.content }}</td>
                        <td><span class="difficulty" :class="difficultyClassMap[question.difficulty]">{{ difficultyStarMap[question.difficulty] }}</span></td>
                        <td>{{ question.score }}</td>
                        <td>{{ question.created_at?.split('T')[0] || '' }}</td>
                        <td>
                            <button class="action-btn edit">编辑</button>
                            <button class="action-btn delete">删除</button>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <!-- 分页 -->
        <div class="pagination" v-if="totalPages > 1">
            <button class="page-btn" :disabled="currentPage === 1" @click="prevPage">上一页</button>
            <span class="page-info">第 {{ currentPage }} 页 / 共 {{ totalPages }} 页</span>
            <button class="page-btn" :disabled="currentPage === totalPages" @click="nextPage">下一页</button>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const questionsArr = ref([])
const searchKeyword = ref('')
const searchType = ref('')
const searchDifficulty = ref('')
const currentPage = ref(1)
const totalPages = ref(1)
const pageSize = 10

// 题型映射
const typeNameMap = {
    single: '单选题',
    multiple: '多选题',
    judge: '判断题',
    fill: '填空题',
    essay: '简答题'
}

const typeClassMap = {
    single: 'single',
    multiple: 'multiple',
    judge: 'judge',
    fill: 'fill',
    essay: 'essay'
}

// 难度映射
const difficultyStarMap = {
    1: '⭐ 简单',
    2: '⭐⭐ 中等',
    3: '⭐⭐⭐ 困难'
}

const difficultyClassMap = {
    1: 'easy',
    2: 'medium',
    3: 'hard'
}

async function loadQuestions() {
    try {
        let url = `/api/v1/questions/selectAllQuestion?page=${currentPage.value}&page_size=${pageSize}`
        if (searchKeyword.value) {
            url += `&keyword=${encodeURIComponent(searchKeyword.value)}`
        }
        if (searchType.value) {
            url += `&type=${searchType.value}`
        }
        if (searchDifficulty.value) {
            url += `&difficulty=${searchDifficulty.value}`
        }
        
        console.log('请求URL:', url)

        const response = await fetch(url)

        if (!response.ok) {
            console.error('获取题目失败:', response.status)
            return
        }

        const data = await response.json()
        questionsArr.value = data.items || []
        totalPages.value = data.total_pages || 1
    } catch (error) {
        console.error('加载题目失败:', error)
    }
}

function prevPage() {
    if (currentPage.value > 1) {
        currentPage.value--
        loadQuestions()
    }
}

function nextPage() {
    if (currentPage.value < totalPages.value) {
        currentPage.value++
        loadQuestions()
    }
}

function handleSearch() {
    console.log('=== 搜索按钮被点击 ===')
    console.log('searchType值:', searchType.value)
    console.log('searchDifficulty值:', searchDifficulty.value)
    console.log('searchKeyword值:', searchKeyword.value)
    currentPage.value = 1
    loadQuestions()
}

function resetSearch() {
    console.log('=== 重置按钮被点击 ===')
    searchKeyword.value = ''
    searchType.value = ''
    searchDifficulty.value = ''
    currentPage.value = 1
    loadQuestions()
}

onMounted(() => {
    console.log('页面挂载完成')
    loadQuestions()
})
</script>

<style scoped>
.questions-container {
    margin-left: 12vw;
    padding: 20px 24px;
    min-height: 100vh;
    box-sizing: border-box;
}

.header-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 28px;
}

.section-title {
    font-size: 1.6rem;
    font-weight: 500;
    color: #2c3e50;
    border-left: 6px solid #409eff;
    padding-left: 16px;
    line-height: 1.3;
    margin: 0;
}

.search-container {
    margin-bottom: 24px;
    width: 700px;
}

.search-box {
    display: flex;
    gap: 10px;
    align-items: center;
    flex-wrap: wrap;
}

.search-input {
    flex: 2;
    min-width: 200px;
    padding: 8px 12px;
    border: 1px solid #dcdfe6;
    border-radius: 6px;
    font-size: 14px;
    outline: none;
}

.type-select,
.difficulty-select {
    padding: 8px 12px;
    border: 1px solid #dcdfe6;
    border-radius: 6px;
    font-size: 14px;
    background: white;
    cursor: pointer;
}

.search-btn {
    padding: 8px 16px;
    background-color: #409eff;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.search-btn:hover {
    background-color: #66b1ff;
}

.reset-btn {
    padding: 8px 16px;
    background-color: #909399;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.reset-btn:hover {
    background-color: #a6a9ad;
}

.table-container {
    background: white;
    border-radius: 12px;
    overflow-x: auto;
    border: 1px solid #e4e7ed;
}

.data-table {
    width: 100%;
    border-collapse: collapse;
}

.data-table th,
.data-table td {
    padding: 14px 16px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

.data-table th {
    background: #f8f9fa;
    font-weight: 600;
    color: #333;
}

.question-content {
    max-width: 400px;
    overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
}

.badge {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
}

.badge.single {
    background: #e3f2fd;
    color: #1976d2;
}

.badge.multiple {
    background: #f3e5f5;
    color: #7b1fa2;
}

.badge.judge {
    background: #fff3e0;
    color: #f57c00;
}

.badge.fill {
    background: #e8f5e9;
    color: #388e3c;
}

.badge.essay {
    background: #fce4ec;
    color: #c2185b;
}

.difficulty {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
}

.difficulty.easy {
    background: #e8f5e9;
    color: #388e3c;
}

.difficulty.medium {
    background: #fff3e0;
    color: #f57c00;
}

.difficulty.hard {
    background: #ffebee;
    color: #d32f2f;
}

.action-btn {
    padding: 6px 12px;
    border: none;
    border-radius: 6px;
    font-size: 12px;
    cursor: pointer;
    margin-right: 6px;
}

.action-btn.edit {
    background: #409eff;
    color: white;
}

.action-btn.edit:hover {
    background: #66b1ff;
}

.action-btn.delete {
    background: #f56c6c;
    color: white;
}

.action-btn.delete:hover {
    background: #f78989;
}

.pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 16px;
    margin-top: 24px;
}

.page-btn {
    padding: 8px 16px;
    border: 1px solid #ddd;
    background: white;
    border-radius: 6px;
    cursor: pointer;
}

.page-btn:hover:not(:disabled) {
    background: #409eff;
    border-color: #409eff;
    color: white;
}

.page-btn:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}

.page-info {
    font-size: 14px;
    color: #666;
}
</style>