<template>
  <div class="dashboard">
    <!-- 左侧导航栏 -->
    <aside class="sidebar">
      <div class="logo">
        <h2>📚 在线考试系统</h2>
        <p>教师工作台</p>
      </div>
      <nav class="nav-menu">
        <div 
          v-for="item in menuItems" 
          :key="item.path"
          class="nav-item" 
          :class="{ active: $route.path === item.path }"
          @click="$router.push(item.path)"
        >
          <span class="icon">{{ item.icon }}</span>
          <span>{{ item.name }}</span>
        </div>
      </nav>
      <div class="user-info">
        <div class="avatar">👨‍🏫</div>
        <div class="user-details">
          <div class="user-name">{{ userStore.userInfo?.username || '李老师' }}</div>
          <div class="user-role">教师</div>
        </div>
        <button class="logout-btn" @click="handleLogout">退出</button>
      </div>
    </aside>

    <!-- 右侧内容区域 -->
    <main class="main-content">
      <router-view />
    </main>
  </div>
</template>

<script setup>
import { useRouter } from 'vue-router'
import { useUserStore } from '@/stores/user'

const router = useRouter()
const userStore = useUserStore()

const menuItems = [
  { path: '/questions', name: '题库管理', icon: '📋' },
  { path: '/exams', name: '试卷管理', icon: '📝' },
  { path: '/scores', name: '成绩管理', icon: '📊' }
]

const handleLogout = () => {
  userStore.logout()
  router.push('/login')
}
</script>

<style scoped>
.dashboard {
  display: flex;
  height: 100vh;
  width: 100%;
}

.sidebar {
  width: 280px;
  background: linear-gradient(180deg, #1a1a2e 0%, #16213e 100%);
  color: white;
  display: flex;
  flex-direction: column;
  box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
}

.logo {
  padding: 30px 24px;
  border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.logo h2 {
  font-size: 20px;
  margin-bottom: 8px;
}

.logo p {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.6);
}

.nav-menu {
  flex: 1;
  padding: 20px 0;
}

.nav-item {
  display: flex;
  align-items: center;
  padding: 14px 24px;
  margin: 4px 12px;
  border-radius: 10px;
  cursor: pointer;
  transition: all 0.3s;
  color: rgba(255, 255, 255, 0.7);
}

.nav-item:hover {
  background: rgba(255, 255, 255, 0.1);
  color: white;
}

.nav-item.active {
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  color: white;
  box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
}

.nav-item .icon {
  font-size: 20px;
  margin-right: 12px;
  width: 28px;
}

.user-info {
  padding: 20px 24px;
  border-top: 1px solid rgba(255, 255, 255, 0.1);
  display: flex;
  align-items: center;
  gap: 12px;
}

.avatar {
  width: 44px;
  height: 44px;
  background: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 22px;
}

.user-details {
  flex: 1;
}

.user-name {
  font-size: 14px;
  font-weight: 600;
  margin-bottom: 4px;
}

.user-role {
  font-size: 12px;
  color: rgba(255, 255, 255, 0.6);
}

.logout-btn {
  background: rgba(255, 255, 255, 0.1);
  border: none;
  color: white;
  padding: 6px 12px;
  border-radius: 6px;
  font-size: 12px;
  cursor: pointer;
  transition: all 0.3s;
}

.logout-btn:hover {
  background: rgba(255, 255, 255, 0.2);
}

.main-content {
  flex: 1;
  overflow-y: auto;
  padding: 24px 32px;
  background: #f0f2f5;
}

.main-content::-webkit-scrollbar {
  width: 8px;
}

.main-content::-webkit-scrollbar-track {
  background: #f1f1f1;
  border-radius: 4px;
}

.main-content::-webkit-scrollbar-thumb {
  background: #ccc;
  border-radius: 4px;
}

.main-content::-webkit-scrollbar-thumb:hover {
  background: #aaa;
}
</style>