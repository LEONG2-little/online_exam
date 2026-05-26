from sqlalchemy.orm import Session
from sqlalchemy import or_
from ..models.question import Question
from ..schemas.question import QuestionCreate, QuestionUpdate

class QuestionService:

    @staticmethod
    def selectAllQuestion(db:Session,page:int=1,page_size:int=10,type:str=None,difficulty:int=None,keyword:str=None):
        """获取题目列表（分页+筛选）"""
        query = db.query(Question)

        #筛选条件
        if type:
            query = query.filter(Question.type == type)
        if difficulty:
            query = query.filter(Question.difficulty == difficulty)
        if keyword:
            query = query.filter(
                or_(
                    Question.content.contains(keyword),
                    Question.answer.contains(keyword)
                )
            )
        
        #计算总数
        total = query.count()

        #分页
        offset = (page - 1) * page_size
        items = query.offset(offset).limit(page_size).all()

        #计算总页数
        total_pages = (total + page_size - 1) // page_size


        return {
            "page": page,
            "page_size": page_size,
            "total": total,
            "total_pages": total_pages,
            "items": items
        }