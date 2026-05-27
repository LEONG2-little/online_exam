from fastapi import APIRouter,Query,Depends
from sqlalchemy.orm import Session
from ...core.database import SessionLocal
from typing import Optional
from ...services.scoring_service import SubmissionService

router = APIRouter()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.get("/selectSubmission")
async def selectSubmission(
        page:int= Query(1,ge=1),
        pageSize:int = Query(8,ge=1,le=8),
        keyword:Optional[str] = Query(None),
        status:Optional[str] = Query(None),
        db:Session = Depends(get_db)
):
    result = SubmissionService.selectSubmission(db,page=page,pageSize=pageSize,keyword=keyword,status=status)
    return result