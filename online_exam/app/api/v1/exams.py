from fastapi import APIRouter
router = APIRouter()

@router.get("/")
async def list_exams():
    return {"message": "试卷列表接口"}