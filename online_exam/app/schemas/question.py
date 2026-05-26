from pydantic import BaseModel, Field
from typing import Optional, List
from datetime import datetime

class QuestionBase(BaseModel):
    """题目基础模型"""
    type: str = Field(..., description="题型: single/multiple/judge/fill/essay")
    content: str = Field(..., description="题目内容")
    options: Optional[dict] = Field(None, description="选项（JSON格式）")
    answer: str = Field(..., description="正确答案")
    analysis: Optional[str] = Field(None, description="解析")
    difficulty: int = Field(1, ge=1, le=3, description="难度 1-3")
    score: float = Field(..., gt=0, description="分值")

class QuestionCreate(QuestionBase):
    """创建题目请求"""
    pass

class QuestionUpdate(BaseModel):
    """更新题目请求"""
    type: Optional[str] = None
    content: Optional[str] = None
    options: Optional[dict] = None
    answer: Optional[str] = None
    analysis: Optional[str] = None
    difficulty: Optional[int] = None
    score: Optional[float] = None

class QuestionResponse(QuestionBase):
    """题目响应模型"""
    question_id: int
    created_at: datetime
    created_by: Optional[int] = None
    
    class Config:
        from_attributes = True

class QuestionListResponse(BaseModel):
    """题目列表响应"""
    page: int
    page_size: int
    total: int
    total_pages: int
    items: List[QuestionResponse]