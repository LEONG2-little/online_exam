from sqlalchemy import Column, Integer, String, Text, JSON, DateTime, Float, Boolean, Enum,ForeignKey
from sqlalchemy.sql import func
from ..core.database import Base


class Exam(Base):
    __tablename__ = "exam"

    exam_id = Column(Integer, primary_key=True, index=True, autoincrement=True)
    title = Column(String(200), nullable=False, comment="试卷标题")
    duration_minutes = Column(Integer, nullable=False, comment="考试时长（分钟）")
    total_score = Column(Float, nullable=False, comment="总分")
    start_time = Column(DateTime, nullable=True, comment="考试开始时间")
    end_time = Column(DateTime, nullable=True, comment="考试结束时间")
    is_random = Column(Boolean, default=False, comment="是否随机抽题：0=固定试卷，1=随机试卷")
    question_ids = Column(JSON, nullable=True, comment="固定试卷的题目ID列表")
    rules = Column(JSON, nullable=True, comment="随机试卷的抽题规则")
    status = Column(Enum('未开放', '开放', '已结束'), default='未开放', comment="试卷状态")
    created_by = Column(Integer, ForeignKey("user.user_id"), nullable=True, comment="创建人ID")
    created_at = Column(DateTime, server_default=func.now(), comment="创建时间")