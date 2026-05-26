from sqlalchemy import Column, Integer, String, Enum, DateTime
from sqlalchemy.sql import func
from ..core.database import Base

class User(Base):
    __tablename__ = "user"

    user_id = Column(Integer, primary_key=True, index=True)
    account = Column(String(50), unique=True, nullable=False)
    username = Column(String(50), nullable=False)
    password = Column(String(255), nullable=False)
    identity_type = Column(Enum('student', 'teacher', 'admin'), default='student')
    phone = Column(String(20), nullable=True)
    email = Column(String(100), nullable=True)
    status = Column(Enum('active', 'inactive'), default='active')
    created_at = Column(DateTime, server_default=func.now())