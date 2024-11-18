from django.db import models

class login_table(models.Model):
    username=models.CharField(max_length=20)
    password=models.CharField(max_length=20)
    type=models.CharField(max_length=20)


class course_table(models.Model):
    name=models.CharField(max_length=50)
    duration=models.CharField(max_length=50)
    details=models.TextField()
    fees=models.FloatField()

class staff_table(models.Model):
    LOGIN = models.ForeignKey(login_table, on_delete=models.CASCADE)
    name=models.CharField(max_length=50)
    photo=models.FileField()
    place=models.CharField(max_length=50)
    post=models.CharField(max_length=50)
    pin=models.BigIntegerField()
    phone=models.BigIntegerField()
    email=models.CharField(max_length=50)
    COURSE=models.ForeignKey(course_table,on_delete=models.CASCADE)


class program_table(models.Model):
    name=models.CharField(max_length=50)
    details=models.CharField(max_length=50)
    date=models.DateField()
    photo=models.FileField()

class subject_table(models.Model):
    name = models.CharField(max_length=50)
    COURSE = models.ForeignKey('course_table', on_delete=models.CASCADE,blank=True,null=True)
    description = models.TextField()
    sem = models.CharField(max_length=20)


class open_course_table(models.Model):
    SUBJECT = models.ForeignKey('subject_table', on_delete=models.CASCADE)
    COURSE = models.ForeignKey('course_table', on_delete=models.CASCADE)



class notes_table(models.Model):
    SUBJECT = models.ForeignKey('subject_table', on_delete=models.CASCADE)
    date = models.DateField()
    title = models.CharField(max_length=50)
    note = models.FileField()


class student_table(models.Model):
    LOGIN = models.ForeignKey('login_table', on_delete=models.CASCADE)
    name = models.CharField(max_length=50)
    photo = models.FileField()
    place = models.CharField(max_length=50)
    post = models.CharField(max_length=50)
    pin = models.IntegerField()
    phone = models.BigIntegerField()
    email = models.EmailField()
    COURSE = models.ForeignKey('course_table', on_delete=models.CASCADE)
    sem = models.CharField(max_length=20)
    # mark = models.CharField(max_length=20)


class feedback_table(models.Model):
     STUDENT = models.ForeignKey('student_table', on_delete=models.CASCADE)
     feedback = models.TextField()
     date = models.DateField()


class qp_table(models.Model):
    SUBJECT = models.ForeignKey('subject_table', on_delete=models.CASCADE)
    title = models.CharField(max_length=50)
    year = models.CharField(max_length=20)
    qp = models.FileField()
    date = models.DateField()

class notification_table(models.Model):
    notification = models.TextField()
    date = models.DateField()


class newsAndEvents_table(models.Model):
    STAFF = models.ForeignKey('staff_table', on_delete=models.CASCADE)
    news_events = models.CharField(max_length=50)
    image = models.FileField()
    details = models.TextField()
    date = models.DateField()


class complaints_table(models.Model):
    STUDENT = models.ForeignKey('student_table', on_delete=models.CASCADE)
    complaint = models.TextField()
    date = models.DateField()
    reply = models.TextField()

class allocate_table(models.Model):
    SUBJECT = models.ForeignKey('subject_table', on_delete=models.CASCADE)
    STAFF = models.ForeignKey('staff_table', on_delete=models.CASCADE)
    date = models.DateField()

class application_table(models.Model):
    COURSE = models.ForeignKey('course_table', on_delete=models.CASCADE)
    STUDENT = models.ForeignKey('student_table', on_delete=models.CASCADE)
    date = models.DateField()
    status = models.CharField(max_length=50)

class auditCourse_table(models.Model):
    name = models.CharField(max_length=50)
    sem = models.CharField(max_length=50)
    COURSE = models.ForeignKey('course_table', on_delete=models.CASCADE)

class result_table(models.Model):
    AUDIT_COURSE = models.ForeignKey('auditCourse_table', on_delete=models.CASCADE)
    STUDENT = models.ForeignKey('student_table', on_delete=models.CASCADE)
    date = models.DateField()
    mark = models.FloatField()


class QuestionsAndAnswers_table(models.Model):
    AUDIT_COURSE = models.ForeignKey('auditCourse_table', on_delete=models.CASCADE)
    question = models.TextField()
    option_1 = models.CharField(max_length=50)
    option_2 = models.CharField(max_length=50)
    option_3 = models.CharField(max_length=50)
    option_4 = models.CharField(max_length=50)
    answer = models.CharField(max_length=50)