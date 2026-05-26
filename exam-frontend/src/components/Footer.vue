<template>
    <footer>
        <ul>
            <router-link to="/questions" custom v-slot="{ navigate }">
                <li @click="navigate" :class="{ active: $route.path === '/questions' }">
                    <i class="fa fa-database"></i>
                    <p>题库管理</p>
                </li>
            </router-link>

            <router-link to="/exams" custom v-slot="{ navigate }">
                <li @click="navigate" :class="{ active: $route.path === '/exams' }">
                    <i class="fa fa-file-text"></i>
                    <p>试卷管理</p>
                </li>
            </router-link>

            <router-link to="/scores" custom v-slot="{ navigate }">
                <li @click="navigate" :class="{ active: $route.path === '/scores' }">
                    <i class="fa fa-bar-chart"></i>
                    <p>成绩管理</p>
                </li>
            </router-link>

            <button @click="logout">退出登录</button>
        </ul>
    </footer>
</template>

<script setup>
import { useRouter } from 'vue-router'

const router = useRouter()

function logout() {
    localStorage.removeItem('access_token')
    localStorage.removeItem('user_info')
    router.push('/login')
}
</script>

<style scoped>
footer {
    width: 12vw;
    height: 100vh;
    box-sizing: border-box;
    border-right: solid 1px #E9E9E9;
    background-color: #FFF;
    position: fixed;
    left: 0;
    top: 0;
    bottom: 0;
}

footer ul {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: flex-start;
    padding-top: 20px;
    margin: 0;
    list-style: none;
}

footer ul li {
    width: 100%;
    padding: 20px 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    font-size: 1.5vw;
    color: #999;
    user-select: none;
    cursor: pointer;
    transition: background-color 0.3s;
}

footer ul li:hover {
    background-color: #f5f5f5;
}

footer ul li .fa {
    font-size: 5vw;
    margin-bottom: 5px;
}

footer ul li.active {
    color: #409eff;
    background-color: #ecf5ff;
    border-left: 3px solid #409eff;
}

footer ul button {
    margin-top: auto;
    margin-bottom: 30px;
    padding: 12px 24px;
    background-color: #f56c6c;
    color: white;
    border: none;
    border-radius: 6px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s;
    width: 80%;
}

footer ul button:hover {
    background-color: #f78989;
    transform: translateY(-1px);
    box-shadow: 0 2px 8px rgba(245, 108, 108, 0.3);
}
</style>