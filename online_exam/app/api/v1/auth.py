from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from ...core.database import SessionLocal
from ...schemas.auth import RegisterRequest, LoginRequest, LoginResponse, MessageResponse, UserInfo
from ...services.auth_service import AuthService

router = APIRouter()

def get_db():
    """依赖注入：获取数据库会话"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/register", response_model=MessageResponse)
async def register(req: RegisterRequest, db: Session = Depends(get_db)):
    """
    用户注册
    - **account**: 学号/工号（唯一）
    - **username**: 姓名
    - **password**: 密码（至少6位）
    - **phone**: 手机号（可选）
    - **email**: 邮箱（可选）
    """
    user, error = AuthService.register(db, req)
    if error:
        raise HTTPException(status_code=400, detail=error)
    return MessageResponse(message="注册成功", success=True)

@router.post("/login", response_model=LoginResponse)
async def login(req: LoginRequest, db: Session = Depends(get_db)):
    """
    用户登录
    - **account**: 学号/工号
    - **password**: 密码
    """
    result, error = AuthService.login(db, req)
    if error:
        raise HTTPException(status_code=401, detail=error)
    return LoginResponse(**result)

@router.get("/me", response_model=UserInfo)
async def get_current_user():
    """
    获取当前登录用户信息（需要JWT token）
    这个接口稍后会完善，现在先返回占位
    """
    # 临时返回，后续会实现JWT解析
    return UserInfo(
        user_id=1,
        account="20240001",
        username="张三",
        identity_type="student",
        phone="13800138000",
        email="zhangsan@example.com",
        status="active",
        created_at="2025-01-01T00:00:00"
    )