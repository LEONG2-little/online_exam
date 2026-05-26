<template>
    <div class="questions-container">
        <div class="header-container">
            <div class="section-title">题库管理</div>
        </div>

        <!-- 搜索筛选栏 -->
        <div class="search-container">
            <div class="search-box">
                <input type="text" v-model="searchKeyword" @input="handleSearch" placeholder="搜索题目内容" class="search-input">
                <select v-model="searchType" @change="handleSearch" class="type-select">
                    <option value="">全部题型</option>
                    <option value="single">单选题</option>
                    <option value="multiple">多选题</option>
                    <option value="judge">判断题</option>
                    <option value="fill">填空题</option>
                    <option value="essay">简答题</option>
                </select>
                <button @click="resetSearch" class="reset-btn">重置</button>
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
                    <tr v-for="question in filteredQuestions" :key="question.question_id">
                        <td>{{ question.question_id }}</td>
                        <td><span class="badge" :class="getTypeClass(question.type)">{{ getTypeName(question.type) }}</span></td>
                        <td class="question-content">{{ question.content }}</td>
                        <td><span class="difficulty" :class="getDifficultyClass(question.difficulty)">{{ getDifficultyStars(question.difficulty) }}</span></td>
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

        <div v-if="filteredQuestions.length === 0 && searchKeyword" class="no-result">
            没有找到匹配的题目
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from 'vue'

const questionsArr = ref([])
const filteredQuestions = ref([])
const searchKeyword = ref('')
const searchType = ref('')

function getAuthToken() {
    return localStorage.getItem('access_token')
}

function getTypeName(type) {
    const types = { single: '单选题', multiple: '多选题', judge: '判断题', fill: '填空题', essay: '简答题' }
    return types[type] || type
}

function getTypeClass(type) {
    const classes = { single: 'single', multiple: 'multiple', judge: 'judge', fill: 'fill', essay: 'essay' }
    return classes[type] || ''
}

function getDifficultyStars(difficulty) {
    const stars = { 1: '⭐ 简单', 2: '⭐⭐ 中等', 3: '⭐⭐⭐ 困难' }
    return stars[difficulty] || '⭐ 简单'
}

function getDifficultyClass(difficulty) {
    const classes = { 1: 'easy', 2: 'medium', 3: 'hard' }
    return classes[difficulty] || 'easy'
}

async function loadQuestions() {
    try {
        const params = new URLSearchParams()
        params.append('page', 1)
        params.append('page_size', 10)

        const response = await fetch(`/api/v1/questions/selectAllQuestion/?${params.toString()}`, {
            headers: { 'Authorization': `Bearer ${getAuthToken()}` }
        })

        if (!response.ok) {
            console.error('获取题目失败:', response.status)
            return
        }

        const data = await response.json()
        questionsArr.value = data.items || []
        filteredQuestions.value = questionsArr.value
    } catch (error) {
        console.error('加载题目失败:', error)
    }
}

function handleSearch() {
    const keyword = searchKeyword.value.trim().toLowerCase()
    const type = searchType.value

    if (!keyword && !type) {
        filteredQuestions.value = questionsArr.value
        return
    }

    filteredQuestions.value = questionsArr.value.filter(q => {
        let keywordMatch = true
        let typeMatch = true

        if (keyword) {
            keywordMatch = q.content?.toLowerCase().includes(keyword)
        }
        if (type) {
            typeMatch = q.type === type
        }
        return keywordMatch && typeMatch
    })
}

function resetSearch() {
    searchKeyword.value = ''
    searchType.value = ''
    filteredQuestions.value = questionsArr.value
}

onMounted(() => {
    loadQuestions()
})
</script>

<style scoped>
.questions-container {
    margin-left: 0vw;
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
    width: 500px;
}

.search-box {
    display: flex;
    gap: 10px;
    align-items: center;
}

.search-input {
    flex: 2;
    padding: 8px 12px;
    border: 1px solid #dcdfe6;
    border-radius: 6px;
    font-size: 14px;
    outline: none;
}

.type-select {
    padding: 8px 12px;
    border: 1px solid #dcdfe6;
    border-radius: 6px;
    font-size: 14px;
    background: white;
    cursor: pointer;
}

.reset-btn {
    padding: 8px 16px;
    background-color: #909399;
    color: white;
    border: none;
    border-radius: 6px;
    cursor: pointer;
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

.badge.single { background: #e3f2fd; color: #1976d2; }
.badge.multiple { background: #f3e5f5; color: #7b1fa2; }
.badge.judge { background: #fff3e0; color: #f57c00; }
.badge.fill { background: #e8f5e9; color: #388e3c; }
.badge.essay { background: #fce4ec; color: #c2185b; }

.difficulty {
    display: inline-block;
    padding: 4px 10px;
    border-radius: 20px;
    font-size: 12px;
}

.difficulty.easy { background: #e8f5e9; color: #388e3c; }
.difficulty.medium { background: #fff3e0; color: #f57c00; }
.difficulty.hard { background: #ffebee; color: #d32f2f; }

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

.action-btn.delete {
    background: #f56c6c;
    color: white;
}

.no-result {
    text-align: center;
    padding: 40px;
    color: #909399;
    background: white;
    border-radius: 8px;
    margin-top: 20px;
}
</style>