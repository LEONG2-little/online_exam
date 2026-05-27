from sqlalchemy.orm import Session
from sqlalchemy import or_
from ..models.exam import Exam

class ExamService:
    @staticmethod
    def selectExams(db:Session,page:int=1,pageSize:int=8,searchKeyword:str=None,searchStatus:str=None):
        query = db.query(Exam)

        if searchStatus:
            query = query.filter(Exam.status == searchStatus)
        if searchKeyword:
            query = query.filter(
                or_(
                    Exam.title.contains(searchKeyword)
                )
            )

        total = query.count()
        offset = (page-1)*pageSize
        items = query.offset(offset).limit(pageSize).all()
        total_pages = (total + pageSize - 1) // pageSize

        return{
            "page":page,
            "pageSize":pageSize,
            "searchKeyword":searchKeyword,
            "searchStatus":searchStatus,
            "total":total,
            "total_pages":total_pages,
            "items":items
        }