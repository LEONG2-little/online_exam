from sqlalchemy import Column, Integer, String, Text, JSON, DateTime, Float, ForeignKey
from sqlalchemy.sql import func
from ..core.database import Base

class Question(Base):
    __tablename__ = "question"

    question_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    type = Column(String(20), nullable=False)  # single, multiple, judge, fill, essay
    content = Column(Text, nullable=False)
    options = Column(JSON, nullable=True)  # 单选题/多选题的选项
    answer = Column(Text, nullable=False)
    analysis = Column(Text, nullable=True)
    difficulty = Column(Integer, default=1)  # 1简单 2中等 3困难
    score = Column(Float, nullable=False)
    created_by = Column(Integer, ForeignKey("user.user_id"), nullable=True)
    created_at = Column(DateTime, server_default=func.now())