from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from typing import Optional
from ..models.user import User
from ..core.security import get_password_hash, verify_password, create_access_token
from ..schemas.auth import RegisterRequest, LoginRequest

class AuthService:
    """认证服务类"""
    
    @staticmethod
    def register(db: Session, req: RegisterRequest):
        """用户注册"""
        #检查账号是否已存在
        existing_user = db.query(User).filter(User.account == req.account).first()
        if existing_user:
            return None, "该账号已被注册"
        
        # 创建新用户
        hashed_password = get_password_hash(req.password)
        new_user = User(
            account=req.account,
            username=req.username,
            password=hashed_password,
            identity_type="student",  # 默认学生身份
            phone=req.phone,
            email=req.email,
            status="active"
        )
        
        try:
            db.add(new_user)
            db.commit()
            db.refresh(new_user)
            return new_user, None
        except IntegrityError:
            db.rollback()
            return None, "注册失败，请稍后重试"
    
    @staticmethod
    def login(db: Session, req: LoginRequest):
        """用户登录"""
        # 根据账号查询用户
        user = db.query(User).filter(User.account == req.account).first()
        
        # 检查用户是否存在
        if not user:
            return None, "账号不存在"
        
        # 检查用户状态
        if user.status != "active":
            return None, "账号已被禁用，请联系管理员"
        
        # 验证密码
        if not verify_password(req.password, user.password):
            return None, "密码错误"
        
        # 生成JWT token
        token_data = {"sub": str(user.user_id), "account": user.account}
        access_token = create_access_token(data=token_data)
        
        return {
            "access_token": access_token,
            "token_type": "bearer",
            "user_id": user.user_id,
            "username": user.username,
            "identity_type": user.identity_type
        }, None