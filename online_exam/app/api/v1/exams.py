from fastapi import APIRouter,Query,Depends
from ...core.database import SessionLocal
from typing import Optional
from ...services.exam_service import ExamService
from sqlalchemy.orm import Session

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/selectExams")
async def selectExams(
    page: int = Query(1,ge=1),
    pageSize: int = Query(8,ge=1,le=8),
    searchKeyword:Optional[str] = Query(None),
    searchStatus:Optional[str] = Query(None),
    db: Session = Depends(get_db)
):
    
    result = ExamService.selectExams(db,page=page,pageSize=pageSize,searchKeyword=searchKeyword,searchStatus=searchStatus)
    return result
    