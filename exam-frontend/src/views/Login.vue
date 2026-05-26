<template>
    <div class="login-container">
        <div class="login-box">
            <div class="login-header">
                <div class="section-title">在线考试系统</div>
            </div>

            <div class="tabs">
                <button class="tab-btn" :class="{ active: activeTab === 'login' }" @click="activeTab = 'login'">登录</button>
                <button class="tab-btn" :class="{ active: activeTab === 'register' }" @click="activeTab = 'register'">注册</button>
            </div>

            <!-- 登录表单 -->
            <div v-show="activeTab === 'login'" class="login-form">
                <div class="input-wrapper">
                    <span class="input-label">账号</span>
                    <input type="text" placeholder="请输入账号" v-model="loginForm.account" class="login-input">
                </div>
                <div class="input-wrapper">
                    <span class="input-label">密码</span>
                    <input type="password" placeholder="请输入密码" v-model="loginForm.password" class="login-input">
                </div>
                <button @click="login" class="login-btn">登录</button>
                <p class="message" :class="loginMessageType">{{ loginMessage }}</p>
            </div>

            <!-- 注册表单 -->
            <div v-show="activeTab === 'register'" class="login-form">
                <div class="input-wrapper">
                    <span class="input-label">学号/工号 <span class="required">*</span></span>
                    <input type="text" v-model="registerForm.account" placeholder="请输入学号或工号" class="login-input">
                </div>
                <div class="input-wrapper">
                    <span class="input-label">姓名 <span class="required">*</span></span>
                    <input type="text" v-model="registerForm.username" placeholder="请输入真实姓名" class="login-input">
                </div>
                <div class="input-wrapper">
                    <span class="input-label">密码 <span class="required">*</span></span>
                    <input type="password" v-model="registerForm.password" placeholder="至少6位" class="login-input">
                </div>
                <div class="input-wrapper">
                    <span class="input-label">确认密码 <span class="required">*</span></span>
                    <input type="password" v-model="registerForm.confirmPassword" placeholder="请再次输入密码" class="login-input">
                </div>
                <div class="input-wrapper">
                    <span class="input-label">手机号</span>
                    <input type="tel" v-model="registerForm.phone" placeholder="选填" class="login-input">
                </div>
                <div class="input-wrapper">
                    <span class="input-label">邮箱</span>
                    <input type="email" v-model="registerForm.email" placeholder="选填" class="login-input">
                </div>
                <button @click="register" class="login-btn">注册</button>
                <p class="message" :class="registerMessageType">{{ registerMessage }}</p>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from 'vue'
import { useRouter } from 'vue-router'

const router = useRouter()

const activeTab = ref('login')
const loginForm = ref({ account: '', password: '' })
const registerForm = ref({ account: '', username: '', password: '', confirmPassword: '', phone: '', email: '' })
const loginMessage = ref('')
const loginMessageType = ref('')
const registerMessage = ref('')
const registerMessageType = ref('')

function showMessage(msg, type, isLogin = true) {
    if (isLogin) {
        loginMessage.value = msg
        loginMessageType.value = type
        setTimeout(() => { loginMessage.value = '' }, 3000)
    } else {
        registerMessage.value = msg
        registerMessageType.value = type
        setTimeout(() => { registerMessage.value = '' }, 3000)
    }
}

async function login() {
    if (!loginForm.value.account || !loginForm.value.password) {
        showMessage('请输入账号和密码', 'error')
        return
    }

    try {
        const response = await fetch('/api/v1/auth/login', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(loginForm.value)
        })
        const data = await response.json()

        if (!response.ok) {
            showMessage(data.detail || '登录失败', 'error')
            return
        }

        localStorage.setItem('access_token', data.access_token)
        localStorage.setItem('user_info', JSON.stringify({
            user_id: data.user_id,
            username: data.username,
            identity_type: data.identity_type
        }))

        showMessage('登录成功！正在跳转...', 'success')
        setTimeout(() => {
            router.push('/questions')
        }, 1000)

    } catch (error) {
        showMessage('网络错误，请稍后重试', 'error')
        console.error('登录错误:', error)
    }
}

async function register() {
    const { account, username, password, confirmPassword, phone, email } = registerForm.value

    if (!account || !username || !password) {
        showMessage('请填写所有必填项', 'error', false)
        return
    }
    if (password.length < 6) {
        showMessage('密码至少6位', 'error', false)
        return
    }
    if (password !== confirmPassword) {
        showMessage('两次输入的密码不一致', 'error', false)
        return
    }

    try {
        const response = await fetch('/api/v1/auth/register', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ account, username, password, phone, email })
        })
        const data = await response.json()

        if (!response.ok) {
            showMessage(data.detail || '注册失败', 'error', false)
            return
        }

        showMessage('注册成功！正在跳转到登录...', 'success', false)
        setTimeout(() => {
            activeTab.value = 'login'
            loginForm.value.account = account
            loginForm.value.password = ''
            showMessage('注册成功，请登录', 'success')
        }, 2000)

    } catch (error) {
        showMessage('网络错误，请稍后重试', 'error', false)
        console.error('注册错误:', error)
    }
}
</script>

<style scoped>
.login-container {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 100vh;
    width: 100vw;
    position: fixed;
    top: 0;
    left: 0;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
}

.login-box {
    width: 100%;
    max-width: 450px;
    background-color: #ffffff;
    border: 1px solid #e4e7ed;
    border-radius: 12px;
    padding: 40px;
    box-sizing: border-box;
}

.login-header {
    margin-bottom: 20px;
}

.section-title {
    font-size: 1.6rem;
    font-weight: 500;
    color: #2c3e50;
    border-left: 6px solid #409eff;
    padding-left: 16px;
    line-height: 1.3;
    margin: 0;
    text-align: left;
}

.tabs {
    display: flex;
    border-bottom: 1px solid #e0e0e0;
    margin-bottom: 24px;
}

.tab-btn {
    flex: 1;
    padding: 10px;
    background: none;
    border: none;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    color: #666;
}

.tab-btn.active {
    color: #409eff;
    border-bottom: 2px solid #409eff;
}

.login-form {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.input-wrapper {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.input-label {
    font-size: 14px;
    color: #606266;
    font-weight: 500;
}

.required {
    color: #e74c3c;
}

.login-input {
    width: 100%;
    padding: 12px 16px;
    border: 1px solid #dcdfe6;
    border-radius: 8px;
    font-size: 15px;
    outline: none;
    box-sizing: border-box;
}

.login-input:focus {
    border-color: #409eff;
}

.login-btn {
    padding: 14px 20px;
    background-color: #409eff;
    color: white;
    border: none;
    border-radius: 8px;
    font-size: 16px;
    font-weight: 500;
    cursor: pointer;
    transition: all 0.3s;
    margin-top: 8px;
}

.login-btn:hover {
    background-color: #66b1ff;
}

.message {
    text-align: center;
    font-size: 14px;
}

.message.error {
    color: #e74c3c;
}

.message.success {
    color: #27ae60;
}
</style>