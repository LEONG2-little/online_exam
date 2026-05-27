from sqlalchemy.orm import Session
from sqlalchemy import or_
from ..models.submission import Submission
from ..models.exam import Exam
from ..models.user import User

class SubmissionService:

    @staticmethod
    def selectSubmission(db:Session,page:int=1,pageSize:int=8,keyword:str=None,status:str=None):
        query = db.query(
            Submission.submission_id,
            Submission.exam_id,
            Submission.user_id,
            Submission.score,
            Submission.status,
            Submission.submit_time,
            Exam.title.label("title"),
            User.username.label("username")
        ).join(Exam,Submission.exam_id == Exam.exam_id)\
            .join(User,Submission.user_id == User.user_id)

        if keyword:
            query = query.filter(
                or_(
                    Exam.title.contains(keyword),
                )
            )
        if status:
            query = query.filter(Submission.status == status)
        
        total = query.count()
        offset = (page-1)*pageSize
        items = query.offset(offset).limit(pageSize).all()
        total_pages = (total + pageSize - 1) // pageSize

        result_items = []
        for item in items:
            result_items.append({
                "submission_id": item.submission_id,
                "exam_id": item.exam_id,
                "user_id": item.user_id,
                "score": float(item.score) if item.score else None,
                "status": item.status,
                "submit_time": item.submit_time.isoformat() if item.submit_time else None,
                "title": item.title,
                "username": item.username
            })

        return{
            "total_pages":total_pages,
            "items":result_items
        }