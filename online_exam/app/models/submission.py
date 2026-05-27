from sqlalchemy import Column, Integer, DateTime, Numeric, JSON, Enum
from sqlalchemy.sql import func
from ..core.database import Base


class Submission(Base):
    __tablename__ = "submission"

    submission_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    exam_id = Column(Integer, nullable=False)
    user_id = Column(Integer, nullable=False)
    answers = Column(JSON, nullable=True)
    score = Column(Numeric(6, 2), nullable=True)
    detail = Column(JSON, nullable=True)
    start_time = Column(DateTime, nullable=True)
    submit_time = Column(DateTime, nullable=True)
    status = Column(Enum('进行中', '已完成', '未完成'), default='进行中')