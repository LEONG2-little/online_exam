from pydantic import BaseModel, Field, EmailStr
from typing import Optional

class RegisterRequest(BaseModel):
    """注册请求体"""
    account: str = Field(..., description="学号/工号", min_length=3, max_length=50)
    username: str = Field(..., description="姓名", min_length=1, max_length=50)
    password: str = Field(..., description="密码", min_length=6)
    phone: Optional[str] = Field(None, description="手机号")
    email: Optional[EmailStr] = Field(None, description="邮箱")

class LoginRequest(BaseModel):
    """登录请求体"""
    account: str = Field(..., description="学号/工号")
    password: str = Field(..., description="密码")

class LoginResponse(BaseModel):
    """登录响应体"""
    access_token: str
    token_type: str = "bearer"
    user_id: int
    username: str
    identity_type: str

class UserInfo(BaseModel):
    """用户信息响应体（不包含密码）"""
    user_id: int
    account: str
    username: str
    identity_type: str
    phone: Optional[str] = None
    email: Optional[str] = None
    status: str
    created_at: str

class MessageResponse(BaseModel):
    """通用消息响应"""
    message: str
    success: bool = True