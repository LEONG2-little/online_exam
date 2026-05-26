from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.responses import RedirectResponse
from .core.database import engine, Base
from .api.v1 import auth, users, questions, exams

#检查数据库是否存在，不存在则创建数据库表
Base.metadata.create_all(bind=engine)

#创建 FastAPI 应用实例
app = FastAPI(title="在线考试系统", version="1.0.0")

# 配置 CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://localhost:5174", "http://127.0.0.1:5173", "http://127.0.0.1:5174"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

#注册路由
app.include_router(auth.router, prefix="/api/v1/auth", tags=["认证"])
app.include_router(users.router, prefix="/api/v1/users", tags=["用户"])
app.include_router(questions.router, prefix="/api/v1/questions", tags=["题库"])
app.include_router(exams.router, prefix="/api/v1/exams", tags=["考试"])

@app.get("/")
def root():
    """根路径重定向到登录页面"""
    return RedirectResponse(url="/static/login.html")

@app.get("/health")
def health():
    return {"status": "ok"}