from fastapi import APIRouter,Query,Depends
from sqlalchemy.orm import Session
from ...core.database import SessionLocal
from typing import Optional
from ...schemas.question import QuestionListResponse
from ...services.question_service import QuestionService

router = APIRouter()

def get_db():
    """依赖注入：获取数据库会话"""
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/selectAllQuestion",response_model=QuestionListResponse)
async def selectAllQuestion(
    page: int = Query(1,ge=1,description="页码"),
    page_size:int = Query(10,ge=1,le=10,description="每页数量"),
    type: Optional[str] = Query(None,description="题型筛选"),
    difficulty: Optional[int] = Query(None,ge=1,le=3,description="难度筛选"),
    keyword: Optional[str] = Query(None,description="关键词搜索"),
    db: Session = Depends(get_db)
):
    """
    获取题目列表（分页 + 筛选）
    """
    result = QuestionService.selectAllQuestion(
        db,page=page,page_size=page_size,type=type,difficulty=difficulty,keyword=keyword
    )
    return result
