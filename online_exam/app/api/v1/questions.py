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

@router.get("/selectAllQuestion")
async def selectAllQuestion(
    page: int = Query(1, ge=1),
    page_size: int = Query(10, ge=1, le=10),
    type: Optional[str] = Query(None),
    difficulty: Optional[int] = Query(None, ge=1, le=3),
    keyword: Optional[str] = Query(None),
    db: Session = Depends(get_db)
):
    
    result = QuestionService.selectAllQuestion(
        db, page=page, page_size=page_size,type=type,difficulty=difficulty,keyword=keyword
    )
    return result
