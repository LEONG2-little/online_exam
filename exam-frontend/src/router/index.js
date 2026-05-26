import { createRouter, createWebHistory } from 'vue-router'
import Login from '../views/Login.vue'
import Questions from '../views/Questions.vue'
import Exams from '../views/Exams.vue'
import Scores from '../views/Scores.vue'

const router = createRouter({
    history: createWebHistory(import.meta.env.BASE_URL),
    routes: [
        { path: '/login', name: 'login', component: Login },
        { path: '/questions', name: 'questions', component: Questions },
        { path: '/exams', name: 'exams', component: Exams },
        { path: '/scores', name: 'scores', component: Scores },
        { path: '/', redirect: '/questions' }
    ]
})

router.beforeEach((to, from, next) => {
    const token = localStorage.getItem('access_token')
    if (to.path !== '/login' && !token) {
        next('/login')
    } else {
        next()
    }
})

export default router