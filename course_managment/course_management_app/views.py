from datetime import datetime

from django.contrib import auth
from django.contrib.auth.decorators import login_required
from django.core.files.storage import FileSystemStorage
from django.http import HttpResponse
from django.shortcuts import render


# Create your views here.

from course_management_app.models import *


def login(request):
    return render(request,'Admin/login.html')

def logout(request):
    auth.logout(request)
    return HttpResponse('''<script>window.location="/"</script>''')

def login_code(request):

    uname=request.POST['username']
    pswd=request.POST['password']

    try:
        user =login_table.objects.get(username=uname,password=pswd)
        if user.type == 'admin':
            ob = auth.authenticate(username="admin",password="admin")
            if ob is not None:
                auth.login(request,ob)
            return HttpResponse('''<script>alert("Welcome to Admin Home");window.location="/admin_home"</script>''')
        elif user.type == 'staff':
            ob = auth.authenticate(username="admin",password="admin")
            if ob is not None:
                auth.login(request,ob)

            request.session['lid']=user.id
            obss=staff_table.objects.get(LOGIN__id=user.id)
            request.session['log_cid']=obss.COURSE.id
            return HttpResponse('''<script>alert("Welcome to staff Home");window.location="/staff_home"</script>''')
        else:
            return HttpResponse('''<script>alert("invalid user");window.location="/"</script>''')
    except:
        return HttpResponse('''<script>alert("invalid");window.location="/"</script>''')


    # --------------------------------- ADMIN ---------------------------------



@login_required(login_url='/')
def admin_home(request):
    return render(request,'Admin/admin-index.html')


@login_required(login_url='/')
def manage_course(request):
    obj = course_table.objects.all()
    return  render(request,'Admin/manage-course.html',{'val':obj})

@login_required(login_url='/')
def manage_subject(request):
    obj=subject_table.objects.all()
    return render(request,'Admin/manage-subject.html',{'val':obj})

@login_required(login_url='/')
def manage_notification(request):
    ntf_obj = notification_table.objects.all()
    return render(request,'Admin/manage-notification.html', {'val':ntf_obj})

@login_required(login_url='/')
def manage_teacher(request):
    staff_obj = staff_table.objects.all()
    return render(request,'Admin/manage-teacher.html', {'val': staff_obj})

@login_required(login_url='/')
def open_course_admin(request):
    open_obj = open_course_table.objects.all()
    c_obj = course_table.objects.all()
    return render(request,'Admin/open-course.html', {'val': open_obj,'course':c_obj})

@login_required(login_url='/')
def manage_program(request):
    program_obj = program_table.objects.all()
    return  render(request,'Admin/manage-program.html', {'val': program_obj})

@login_required(login_url='/')
def audit_course_admin(request):
    audit_obj = auditCourse_table.objects.all()
    return  render(request,'Admin/audit-course.html', {'val': audit_obj})


@login_required(login_url='/')
def audit_questions_admin(request,id):
    request.session['audit_id'] = id
    obj = QuestionsAndAnswers_table.objects.filter(AUDIT_COURSE__id=id)
    audit = auditCourse_table.objects.get(id=id)
    return render(request, 'Admin/manage-audit-questions.html', {'val': obj, 'name': audit.name})

@login_required(login_url='/')
def search_audit_questions_admin(request):
    id=request.session['audit_id']
    sr=request.POST['search']
    audit = auditCourse_table.objects.get(id=id)

    if sr == "all":
       obj = QuestionsAndAnswers_table.objects.all()
       return render(request,'Admin/manage-audit-questions.html',{'val':obj,'name':audit.name,"sr":sr})
    
    obj = QuestionsAndAnswers_table.objects.filter(AUDIT_COURSE__id=id,question__startswith=sr)
    return render(request,'Admin/manage-audit-questions.html',{'val':obj,'name':audit.name,"sr":sr})




@login_required(login_url='/')
def add_course(request):
    return render(request,'Admin/add-course.html')

@login_required(login_url='/')
def add_course_post(request):
    Name = request.POST['Name']
    Duration = request.POST['Duration']
    Details = request.POST['Details']
    Fees = request.POST['Fees']

    course_obj = course_table()
    course_obj.name = Name
    course_obj.duration = Duration
    course_obj.details = Details
    course_obj.fees = Fees
    course_obj.save()

    return HttpResponse('''<script>alert("course added successfully");window.location="/manage_course#about"</script>''')


@login_required(login_url='/')
def add_subject(request):
    course_obj = course_table.objects.all()
    return  render(request,'Admin/add-subject.html',{'val':course_obj})


@login_required(login_url='/')
def add_subject_post(request):
    name=request.POST['name']
    course=request.POST['course']
    description=request.POST['description']
    sem=request.POST['sem']
    if course != 'oc':
        subject_obj = subject_table()
        subject_obj.name = name
        subject_obj.description = description
        subject_obj.sem = sem
        subject_obj.COURSE=course_table.objects.get(id=course)
        subject_obj.save()
    else:
        subject_obj = subject_table()
        subject_obj.name = name
        subject_obj.description = description
        subject_obj.sem = sem
        subject_obj.save()

    return HttpResponse('''<script>alert("subject added successfully");window.location="/manage_subject#about"</script>''')



@login_required(login_url='/')
def add_open_course_admin(request):
    c_obj = course_table.objects.all()
    s_obj = subject_table.objects.all()
    return render(request, 'Admin/add-open-course.html', {'course': c_obj, 'subject': s_obj})


@login_required(login_url='/')
def add_open_course_post_admin(request):
    course = request.POST['course']
    subject = request.POST['subject']

    open = open_course_table.objects.filter(COURSE__id=course,SUBJECT__id=subject)
    if len(open)==0:
        open_obj = open_course_table()
        open_obj.COURSE = course_table.objects.get(id=course)
        open_obj.SUBJECT = subject_table.objects.get(id=subject)
        open_obj.save()
        return HttpResponse('''<script>alert("course added successfully");window.location="/open_course_admin#about"</script>''')
    else:

        return HttpResponse(
            '''<script>alert("duplication detected");window.location="/open_course_admin#about"</script>''')

@login_required(login_url='/')
def add_notification(request):
    return  render(request, 'Admin/add-notification.html')


@login_required(login_url='/')
def add_notification_post(request):
    notification = request.POST['notification']


    ntf_obj = notification_table()
    ntf_obj.notification = notification
    ntf_obj.date = datetime.today()
    ntf_obj.save()

    return HttpResponse('''<script>alert("notification added successfully");window.location="/manage_notification#about"</script>''')


@login_required(login_url='/')
def add_program(request):
    return render(request, 'Admin/add-program.html')


@login_required(login_url='/')
def add_program_post(request):
    name = request.POST['name']
    photo = request.FILES['photo']
    fss = FileSystemStorage()
    photo_file = fss.save(photo.name, photo)
    details = request.POST['details']
    date = request.POST['date']

    program_obj = program_table()
    program_obj.name = name
    program_obj.details = details
    program_obj.date = date
    program_obj.photo = photo_file
    program_obj.save()

    return HttpResponse('''<script>alert("program added successfully");window.location="/manage_program#about"</script>''')


@login_required(login_url='/')
def add_teacher(request):
    course_obj = course_table.objects.all()
    return  render(request,'Admin/add-teacher.html',{'val': course_obj})


@login_required(login_url='/')
def add_teacher_post(request):
    name=request.POST['Name']
    photo=request.FILES['file']
    fss = FileSystemStorage()
    photo_file = fss.save(photo.name, photo)
    place=request.POST['place']
    Post=request.POST['Post']
    Pin=request.POST['Pin']
    Phone=request.POST['Phone']
    Email=request.POST['Email']
    course=request.POST['course']
    Username=request.POST['Username']
    Password=request.POST['Password']

    login_obj = login_table()
    login_obj.username = Username
    login_obj.password = Password
    login_obj.type = 'staff'
    login_obj.save()

    staff_obj = staff_table()
    staff_obj.name = name
    staff_obj.photo = photo_file
    staff_obj.place = place
    staff_obj.post = Post
    staff_obj.pin = Pin
    staff_obj.phone = Phone
    staff_obj.email = Email
    staff_obj.COURSE = course_table.objects.get(id=course)
    staff_obj.LOGIN = login_obj
    staff_obj.save()
    return HttpResponse('''<script>alert("teacher added successfully");window.location="/manage_teacher#about"</script>''')



@login_required(login_url='/')
def add_audit_course(request):
    obj =course_table.objects.all()
    return render(request,'Admin/add-audit-course.html',{'val':obj})


@login_required(login_url='/')
def add_audit_course_post(request):
    name = request.POST['name']
    sem = request.POST['sem']
    course = request.POST['course']

    audit_obj = auditCourse_table()
    audit_obj.name = name
    audit_obj.sem = sem
    audit_obj.COURSE = course_table.objects.get(id=course)
    audit_obj.save()

    return HttpResponse('''<script>alert("course added successfully");window.location="/audit_course_admin#about"</script>''')


@login_required(login_url='/')
def add_audit_questions(request):
    obj =course_table.objects.all()
    return render(request,'Admin/add-audit-questions.html',{'val':obj})


@login_required(login_url='/')
def add_audit_questions_post(request):
    question = request.POST['question']
    option_1 = request.POST['option_1']
    option_2 = request.POST['option_2']
    option_3 = request.POST['option_3']
    option_4 = request.POST['option_4']
    answer = request.POST['answer']

    q_obj = QuestionsAndAnswers_table()
    q_obj.question = question
    q_obj.option_1 = option_1
    q_obj.option_2 = option_2
    q_obj.option_3 = option_3
    q_obj.option_4 = option_4
    q_obj.answer = answer
    q_obj.AUDIT_COURSE = auditCourse_table.objects.get(id=request.session['audit_id'])
    q_obj.save()

    return HttpResponse('''<script>alert("course added successfully");window.location="/audit_course_admin#about"</script>''')

@login_required(login_url='/')
def edit_teacher(request, id):
    request.session['staff_id'] = id
    course_obj = course_table.objects.all()
    stf_obj = staff_table.objects.get(id=id)
    return render(request,'Admin/edit-teacher.html',{'staff':stf_obj,'course':course_obj})


@login_required(login_url='/')
def edit_teacher_post(request):
    try:
        name = request.POST['Name']
        photo = request.FILES['file']
        fss = FileSystemStorage()
        photo_file = fss.save(photo.name, photo)
        place = request.POST['place']
        Post = request.POST['Post']
        Pin = request.POST['Pin']
        Phone = request.POST['Phone']
        Email = request.POST['Email']
        course = request.POST['course']

        staff_obj = staff_table.objects.get(id=request.session['staff_id'])
        staff_obj.name = name
        staff_obj.photo = photo_file
        staff_obj.place = place
        staff_obj.post = Post
        staff_obj.pin = Pin
        staff_obj.phone = Phone
        staff_obj.email = Email
        staff_obj.COURSE = course_table.objects.get(id=course)
        staff_obj.save()

        return HttpResponse('''<script>alert("edited successfully");window.location="/manage_teacher#about"</script>''')
    except:
        name = request.POST['Name']
        place = request.POST['place']
        Post = request.POST['Post']
        Pin = request.POST['Pin']
        Phone = request.POST['Phone']
        Email = request.POST['Email']
        course = request.POST['course']

        staff_obj = staff_table.objects.get(id=request.session['staff_id'])
        staff_obj.name = name
        staff_obj.place = place
        staff_obj.post = Post
        staff_obj.pin = Pin
        staff_obj.phone = Phone
        staff_obj.email = Email
        staff_obj.COURSE = course_table.objects.get(id=course)
        staff_obj.save()

        return HttpResponse('''<script>alert("edited successfully");window.location="/manage_teacher#about"</script>''')
    

@login_required(login_url='/')
def edit_course(request, id):
    request.session['course_id'] = id
    course_obj = course_table.objects.get(id=id)
    return render(request,'Admin/edit-course.html',{'course':course_obj})


@login_required(login_url='/')
def edit_course_post(request):
    Name = request.POST['Name']
    Duration = request.POST['Duration']
    Details = request.POST['Details']
    Fees = request.POST['Fees']

    course_obj = course_table.objects.get(id=request.session['course_id'])
    course_obj.name = Name
    course_obj.duration = Duration
    course_obj.details = Details
    course_obj.fees = Fees
    course_obj.save()

    return HttpResponse('''<script>alert("edited successfully");window.location="/manage_course#about"</script>''')


@login_required(login_url='/')
def edit_subject(request, id):
    request.session['subject_id'] = id
    subject_obj = subject_table.objects.get(id=id)
    course_obj = course_table.objects.all()
    return render(request,'Admin/edit-subject.html',{'subject':subject_obj,'course':course_obj})



@login_required(login_url='/')
def edit_subject_post(request):
    name=request.POST['name']
    course=request.POST['course']
    description=request.POST['description']
    sem=request.POST['sem']

    if course != 'oc':
        subject_obj = subject_table.objects.get(id=request.session['subject_id'])
        subject_obj.name = name
        subject_obj.description = description
        subject_obj.sem = sem
        subject_obj.COURSE = course_table.objects.get(id=course)
        subject_obj.save()
    else:
        subject_obj = subject_table.objects.get(id=request.session['subject_id'])
        subject_obj.name = name
        subject_obj.description = description
        subject_obj.sem = sem
        subject_obj.save()
    return HttpResponse('''<script>alert("edited successfully");window.location="/manage_subject#about"</script>''')


@login_required(login_url='/')
def edit_program(request, id):
    request.session['program_id'] = id
    program_obj = program_table.objects.get(id=id)
    date=program_obj.date
    day = "0"+str(date.day) if  date.day<10 else date.day;
    month = "0"+str(date.month) if  date.month<10 else date.month;
    date=str(date.year)+"-"+str(month)+"-"+str(day)
    program_obj.date=date
    return render(request,'Admin/edit-program.html',{'program':program_obj})



@login_required(login_url='/')
def edit_program_post(request):
    try:
        name = request.POST['name']
        photo = request.FILES['photo']
        fss = FileSystemStorage()
        photo_file = fss.save(photo.name, photo)
        details = request.POST['details']
        date = request.POST['date']

        program_obj = program_table.objects.get(id=request.session['program_id'])
        program_obj.name = name
        program_obj.details = details
        program_obj.date = date
        program_obj.photo = photo_file
        program_obj.save()

    except:
        name = request.POST['name']
        details = request.POST['details']
        date = request.POST['date']
     
        program_obj = program_table.objects.get(id=request.session['program_id'])
        program_obj.name = name
        program_obj.details = details
        program_obj.date = date
        program_obj.save()



    return HttpResponse('''<script>alert("program edited successfully");window.location="/manage_program#about"</script>''')


@login_required(login_url='/')
def delete_teacher(request, id):
    stf_obj = staff_table.objects.get(id=id)
    lgn_obj= login_table.objects.get(id=stf_obj.LOGIN.id)
    lgn_obj.delete()

    return HttpResponse('''<script>alert("deleted successfully");window.location="/manage_teacher#about"</script>''')


@login_required(login_url='/')
def delete_course(request, id):
    crs_obj = course_table.objects.get(id=id)
    crs_obj.delete()

    return HttpResponse('''<script>alert("deleted successfully");window.location="/manage_course#about"</script>''')


@login_required(login_url='/')
def delete_subject(request, id):
    sbj_obj = subject_table.objects.get(id=id)
    sbj_obj.delete()
    return HttpResponse('''<script>alert("deleted successfully");window.location="/manage_subject#about"</script>''')


@login_required(login_url='/')
def delete_program(request, id):
    prg_obj = program_table.objects.get(id=id)
    prg_obj.delete()
    return HttpResponse('''<script>alert("deleted successfully");window.location="/manage_program#about"</script>''')


@login_required(login_url='/')
def delete_subject_allocation(request, id):
    alc_obj = allocate_table.objects.get(id=id)
    alc_obj.delete()
    return HttpResponse('''<script>alert("deleted successfully");window.location="/manage_subject_allocation#about"</script>''')


@login_required(login_url='/')
def delete_notification(request, id):
    ntf_obj = notification_table.objects.get(id=id)
    ntf_obj.delete()
    return HttpResponse('''<script>alert("deleted successfully");window.location="/manage_notification#about"</script>''')


@login_required(login_url='/')
def delete_audit_question(request, id):
    q_obj = QuestionsAndAnswers_table.objects.get(id=id)
    q_obj.delete()
    return HttpResponse('''<script>alert("deleted successfully");window.location="/audit_course_admin#about"</script>''')


@login_required(login_url='/')
def delete_open_course_admin(request,id):
    open_course_table.objects.get(id=id).delete()
    return HttpResponse('''<script>alert(' success ');window.location='/open_course_admin#about'</script>''')



@login_required(login_url='/')
def complaints(request):
    complaints_obj = complaints_table.objects.all()
    return  render(request,'Admin/complaints.html', {'val': complaints_obj})


@login_required(login_url='/')
def manage_subject_allocation(request):
    allocate_obj=allocate_table.objects.all()
    return render(request,'Admin/manage-subject-allocation.html', {"val": allocate_obj})


@login_required(login_url='/')
def subject_allocation(request):
    stf_obj=staff_table.objects.all()
    ob=allocate_table.objects.all()
    r=[]
    for i in ob:
        r.append(i.SUBJECT.id)
    sbj_obj = subject_table.objects.exclude(id__in=r)
    return render(request, 'Admin/subject-allocation.html',{"staff": stf_obj, "subject": sbj_obj})


@login_required(login_url='/')
def subject_allocation_post(request):
    staff = request.POST['staff']
    subject = request.POST['subject']

    allocate_obj = allocate_table()
    allocate_obj.SUBJECT = subject_table.objects.get(id=subject)
    allocate_obj.STAFF = staff_table.objects.get(id=staff)
    allocate_obj.date = datetime.today()
    allocate_obj.save()

    return HttpResponse('''<script>alert("allocation successfully");window.location="/manage_subject_allocation#about"</script>''')



@login_required(login_url='/')
def view_news_events(request):
    evt_obj = newsAndEvents_table.objects.all()
    return render(request,'Admin/view-news-events.html', {'val': evt_obj})


@login_required(login_url='/')
def view_feedback(request):
    fdb_obj = feedback_table.objects.all()
    return  render(request,'Admin/view-feedback.html',{'val':fdb_obj})


@login_required(login_url='/')
def view_notes(request):
    notes_obj = notes_table.objects.all()
    for i in notes_obj:
        ob=allocate_table.objects.get(SUBJECT__id=i.SUBJECT.id)
        i.sname=ob.STAFF.name
    return  render(request,'Admin/view-notes.html',{'val': notes_obj})


@login_required(login_url='/')
def view_qp(request):
    qp_obj = qp_table.objects.all()
    for i in qp_obj:
        ob=allocate_table.objects.get(SUBJECT__id=i.SUBJECT.id)
        i.sname=ob.STAFF.name
    return render(request,'Admin/view-qp.html',{'val': qp_obj})



@login_required(login_url='/')
def view_students(request):
    std_obj = student_table.objects.all()
    return render(request,'Admin/view-students.html', {'val': std_obj})


@login_required(login_url='/')
def search_teacher(request):
    search = request.POST['search']
    obj = staff_table.objects.filter(name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_teacher#about"</script>''')
    else:
        return render(request, 'Admin/manage-teacher.html', {'val': obj,'sr': search})

@login_required(login_url='/')
def search_course(request):
    search = request.POST['search']
    print(search)
    obj = course_table.objects.filter(name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_course#about"</script>''')

    else:
        return render(request, 'Admin/manage-course.html', {'val': obj, 'sr': search})

@login_required(login_url='/')
def search_subject(request):
    search = request.POST['search']
    obj = subject_table.objects.filter(name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_subject#about"</script>''')

    else:
        return render(request, 'Admin/manage-subject.html', {'val': obj, 'sr': search})

@login_required(login_url='/')
def search_notes(request):
    search = request.POST['search']
    obj = notes_table.objects.filter(title__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_notes#about"</script>''')
    else:
        return render(request, 'Admin/view-notes.html', {'val': obj, 'sr': search})


@login_required(login_url='/')
def search_qp(request):
    search = request.POST['search']
    obj = qp_table.objects.filter(title__istartswith=search)
    if len(obj) == 0:
        return HttpResponse(
                        '''<script>alert("no result found");window.location="/view_qp#about"</script>''')
    else:
        return render(request, 'Admin/view-qp.html', {'val': obj, 'sr': search})

@login_required(login_url='/')
def search_program_admin(request):
    search = request.POST['search']
    obj = program_table.objects.filter(name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_program#about"</script>''')
    else:
        return render(request, 'Admin/manage-program.html', {'val': obj, 'sr': search})

@login_required(login_url='/')
def search_subject_allocation(request):
    search = request.POST['search']
    obj = allocate_table.objects.filter(title__istartswith=search)
    if len(obj) == 0:
        return HttpResponse(
            '''<script>alert("no result found");window.location="/manage_subject_allocation#about"</script>''')
    else:
        return render(request, 'Admin/manage-subject-allocation.html', {'val': obj, 'sr': search})



@login_required(login_url='/')
def search_events(request):
    search = request.POST['search']
    obj = newsAndEvents_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_news_events#about"</script>''')
    else:
        return render(request, 'Admin/view-news-events.html', {'val': obj, 'sr': search})

@login_required(login_url='/')
def search_students(request):
    search = request.POST['search']
    obj = student_table.objects.filter(COURSE__name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_students#about"</script>''')
    else:
        return render(request, 'Admin/view-students.html', {'val': obj, 'sr': search})
    
@login_required(login_url='/')
def search_feedback(request):
    search = request.POST['search']
    obj = feedback_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_feedback#about"</script>''')
    else:
        return render(request, 'Admin/view-feedback.html', {'val': obj, 'sr': search})  

@login_required(login_url='/')
def search_complaint(request):
    search = request.POST['search']
    obj = complaints_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/complaints#about"</script>''')
    else:
        return render(request, 'Admin/complaints.html', {'val': obj, 'sr': search})        


@login_required(login_url='/')
def search_notification(request):
    search = request.POST['search']
    obj = notification_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_notification#about"</script>''')
    else:
        return render(request, 'Admin/manage-notification.html', {'val': obj, 'sr': search})
@login_required(login_url='/')
def search_open_course_admin(request):
    search = request.POST['search']
    obj = open_course_table.objects.filter(COURSE__name__istartswith=search)
    c_obj = course_table.objects.all()
    if len(obj) == 0:
         return HttpResponse('''<script>alert("no result found");window.location="/open_course_admin#about"</script>''')
    else:
         return render(request, 'Admin/open-course.html', {'val': obj, 'sr': search, 'course': c_obj})

@login_required(login_url='/')
def search_audit_admin(request):
    search = request.POST['search']
    print(search)
    obj = auditCourse_table.objects.filter(name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/audit_course_admin#about"</script>''')

    else:
        return render(request, 'Admin/audit-course.html', {'val': obj, 'sr': search})




                # --------------------------------- STAFF ---------------------------------



def staff_home(request):
    return render(request,'Staff/staff-index.html')



def open_course_staff(request):
    open_obj = open_course_table.objects.filter(COURSE__id=request.session['log_cid'])
    c_obj = course_table.objects.all()
    return render(request,'Staff/open-course.html', {'val': open_obj,'course':c_obj})



def manage_qp(request):
    ob=allocate_table.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    r=[]
    for i in ob:
        r.append(i.SUBJECT.id)
    qp_obj = qp_table.objects.filter(SUBJECT__id__in=r)
    sbj_obj = subject_table.objects.filter(id__in=r)
    return  render(request,'Staff/manage-qp.html',{'val':qp_obj,'subject':sbj_obj})


def manage_notes(request):
    ob = allocate_table.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    r = []
    for i in ob:
        r.append(i.SUBJECT.id)
    notes_obj = notes_table.objects.filter(SUBJECT__id__in=r)
    subject_obj = subject_table.objects.filter(id__in=r)

    return  render(request,'Staff/manage-notes.html',{'val':notes_obj,'subject':subject_obj})


def manage_news_events(request):
    obj = newsAndEvents_table.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    return  render(request,'Staff/manage-news-events.html',{'val':obj})


def add_open_course(request):
    c_obj = course_table.objects.all()
    s_obj = subject_table.objects.all()
    return render(request, 'Staff/add-open-course.html', {'course': c_obj, 'subject': s_obj})


def add_open_course_post(request):
    course = request.POST['course']
    subject = request.POST['subject']

    open_obj = open_course_table()
    open_obj.COURSE = course_table.objects.get(id=course)
    open_obj.SUBJECT = subject_table.objects.get(id=subject)
    open_obj.save()
    return HttpResponse('''<script>alert("course added successfully");window.location="/open_course_staff#about"</script>''')


def add_news_events(request):
    return  render(request,'Staff/add-news-events.html')

def add_news_events_post(request):
    news = request.POST['news']
    file = request.FILES['file']
    details = request.POST['details']
    date = request.POST['date']
    
    fss = FileSystemStorage()
    file = fss.save(file.name, file)

    obj = newsAndEvents_table()
    obj.news_events = news
    obj.image = file
    obj.details = details
    obj.date = date
    obj.STAFF=staff_table.objects.get(LOGIN__id=request.session['lid'])
    obj.save()

    return HttpResponse('''<script>alert(' success ');window.location='/manage_news_events#about'</script>''')



def add_notes(request):
    ob=allocate_table.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    r=[]
    for i in ob:
        r.append(i.SUBJECT.id)
    subject_obj = subject_table.objects.filter(id__in=r)
    return  render(request,'Staff/add-notes.html',{'subject':subject_obj})

def add_notes_post(request):
    subject=request.POST['subject']
    title=request.POST['title']
    note=request.FILES['note']
    fss = FileSystemStorage()
    note_file = fss.save(note.name, note)

    note_obj = notes_table()
    note_obj.SUBJECT = subject_table.objects.get(id=subject)
    note_obj.title = title
    note_obj.date = datetime.today()
    note_obj.note = note_file
    note_obj.save()
    return HttpResponse('''<script>alert(' success ');window.location='/manage_notes#about'</script>''')



def add_qp(request):
    ob = allocate_table.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    r = []
    for i in ob:
        r.append(i.SUBJECT.id)
    subject_obj = subject_table.objects.filter(id__in=r)
    return  render(request,'Staff/add-qp.html',{'val':subject_obj})

def add_qp_post(request):
    subject=request.POST['subject']
    title=request.POST['title']
    year=request.POST['year']
    qp=request.FILES['qp']
    fss = FileSystemStorage()
    qp_file = fss.save(qp.name, qp)

    qp_obj = qp_table()
    qp_obj.SUBJECT = subject_table.objects.get(id=subject)
    qp_obj.title = title
    qp_obj.year = year
    qp_obj.date = datetime.today()
    qp_obj.qp = qp_file
    qp_obj.save()
    return HttpResponse('''<script>alert(' success ');window.location='/manage_qp#about'</script>''')


# def edit_open_course_staff(request, id):
#     request.session['open_id'] = id
#     course_obj = course_table.objects.get(id=id)
#     subject_obj = subject_table.objects.get(id=id)
#     return render(request, 'Staff/edit-open-course.html', {'course': course_obj,'subject':subject_obj})
#
#
# def edit_open_course_post_staff(request):
#     Name = request.POST['Name']
#     Duration = request.POST['Duration']
#     Details = request.POST['Details']
#     Fees = request.POST['Fees']
#
#     course_obj = course_table.objects.get(id=request.session['course_id'])
#     course_obj.name = Name
#     course_obj.duration = Duration
#     course_obj.details = Details
#     course_obj.fees = Fees
#     course_obj.save()
#
#     return HttpResponse('''<script>alert("edited successfully");window.location="/manage_course"</script>''')


def edit_qp(request, id):
     ob = allocate_table.objects.filter(STAFF__LOGIN__id=request.session['lid'])
     r = []
     for i in ob:
            r.append(i.SUBJECT.id)
     subject_obj = subject_table.objects.filter(id__in=r)

     request.session['qp_id'] = id
     qp_obj = qp_table.objects.get(id=id)
     return  render(request,'Staff/edit-qp.html',{'qp':qp_obj,'subject':subject_obj})

def edit_qp_post(request):
    try:
        subject=request.POST['subject']
        title=request.POST['title']
        year=request.POST['year']
        qp=request.FILES['qp']
        fss = FileSystemStorage()
        qp_file = fss.save(qp.name, qp)

        qp_obj = qp_table.objects.get(id=request.session['qp_id'])
        qp_obj.SUBJECT = subject_table.objects.get(id=subject)
        qp_obj.title = title
        qp_obj.year = year
        qp_obj.date = datetime.today()
        qp_obj.qp = qp_file
        qp_obj.save()
        return HttpResponse('''<script>alert(' success ');window.location='/manage_qp#about'</script>''')
    except:
        subject=request.POST['subject']
        title=request.POST['title']
        year=request.POST['year']
        

        qp_obj = qp_table.objects.get(id=request.session['qp_id'])
        qp_obj.SUBJECT = subject_table.objects.get(id=subject)
        qp_obj.title = title
        qp_obj.year = year
        qp_obj.date = datetime.today()
        qp_obj.save()
        return HttpResponse('''<script>alert(' success ');window.location='/manage_qp#about'</script>''')
    

def edit_note(request,id):
    ob = allocate_table.objects.filter(STAFF__LOGIN__id=request.session['lid'])
    r = []
    for i in ob:
        r.append(i.SUBJECT.id)
    subject_obj = subject_table.objects.filter(id__in=r)

    note_obj = notes_table.objects.get(id=id)
    request.session['note_id'] = id
    return  render(request,'Staff/edit-note.html',{'subject':subject_obj,'note':note_obj})

def edit_note_post(request):
    try:
        subject=request.POST['subject']
        title=request.POST['title']
        note=request.FILES['note']
        fss = FileSystemStorage()
        note_file = fss.save(note.name, note)

        note_obj = notes_table.objects.get(id = request.session['note_id'] )
        note_obj.SUBJECT = subject_table.objects.get(id=subject)
        note_obj.title = title
        note_obj.date = datetime.today()
        note_obj.note = note_file
        note_obj.save()
        return HttpResponse('''<script>alert(' success ');window.location='/manage_notes#about'</script>''')
    except:
        subject=request.POST['subject']
        title=request.POST['title']

        note_obj = notes_table.objects.get(id = request.session['note_id'] )
        note_obj.SUBJECT = subject_table.objects.get(id=subject)
        note_obj.title = title
        note_obj.date = datetime.today()
        note_obj.save()
        return HttpResponse('''<script>alert(' success ');window.location='/manage_notes#about'</script>''')
        

def edit_news_event(request,id):
    obj = newsAndEvents_table.objects.get(id=id)
    request.session['news_id'] = id
    date=obj.date
    day = "0"+str(date.day) if  date.day<10 else date.day;
    month = "0"+str(date.month) if  date.month<10 else date.month;
    date=str(date.year)+"-"+str(month)+"-"+str(day)
    obj.date=date
    return  render(request,'Staff/edit-news-event.html',{'val':obj})


def edit_news_event_post(request):
    try:
        news = request.POST['news']
        file = request.FILES['file']
        details = request.POST['details']
        date = request.POST['date']
        
        fss = FileSystemStorage()
        file = fss.save(file.name, file)

        obj = newsAndEvents_table.objects.get(id = request.session['news_id'] )
        obj.news_events = news
        obj.image = file
        obj.details = details
        obj.date = date
        obj.STAFF=staff_table.objects.get(id=request.session['lid'])
        obj.save()

        return HttpResponse('''<script>alert(' success ');window.location='/manage_news_events#about'</script>''')

    except:
        news = request.POST['news']
        details = request.POST['details']
        date = request.POST['date']
    
        obj = newsAndEvents_table.objects.get(id = request.session['news_id'] )
        obj.news_events = news
        obj.details = details
        obj.date = date
        obj.STAFF=staff_table.objects.get(LOGIN_id=request.session['lid'])
        obj.save()

        return HttpResponse('''<script>alert(' success ');window.location='/manage_news_events#about'</script>''')



def delete_open_course_staff(request,id):
    open_course_table.objects.get(id=id).delete()
    return HttpResponse('''<script>alert(' success ');window.location='/open_course_staff#about'</script>''')


def delete_qp(request,id):
    qp_table.objects.get(id=id).delete()
    return HttpResponse('''<script>alert(' success ');window.location='/manage_qp#about'</script>''')

def delete_note(request,id):
    notes_table.objects.get(id = id).delete()
    return HttpResponse('''<script>alert(' success ');window.location='/manage_notes#about'</script>''')

def delete_news_event(request,id):
    newsAndEvents_table.objects.get(id = id).delete()
    return HttpResponse('''<script>alert(' success ');window.location='/manage_news_events#about'</script>''')


def search_open_course_staff(request):
    search = request.POST['search']
    obj = open_course_table.objects.filter(COURSE__name__istartswith=search)
    c_obj = course_table.objects.all()
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/open_course_staff#about"</script>''')
    else:
        return render(request, 'Staff/open-course.html', {'val': obj, 'sr': search,'course':c_obj})


def search_qp_staff(request):
    search = request.POST['search']
    obj = qp_table.objects.filter(SUBJECT__name__istartswith=search)
    sub_obj = subject_table.objects.all()

    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_qp#about"</script>''')
    else:
        print(search)
        return render(request, 'Staff/manage-qp.html', {'val': obj, 'sr': search,'subject':sub_obj})


def search_notes_staff(request):
    search = request.POST['search']
    obj = notes_table.objects.filter(SUBJECT__name__istartswith=search)
    sub_obj = subject_table.objects.all()

    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_notes#about"</script>''')
    else:
        return render(request, 'Staff/manage-notes.html', {'val': obj, 'sr': search,'subject':sub_obj})
    

def search_events_staff(request):
    search = request.POST['search']
    obj = newsAndEvents_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/manage_news_events#about"</script>''')
    else:
        return render(request, 'Staff/manage-news-events.html', {'val': obj, 'sr': search})   
    

def search_students_staff(request):
    search = request.POST['search']
    obj = student_table.objects.filter(name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_students_staff#about"</script>''')
    else:
        return render(request, 'Staff/view-students.html', {'val': obj, 'sr': search})


def search_complaint_staff(request):
    search = request.POST['search']
    obj = complaints_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_complaints_staff#about"</script>''')
    else:
        return render(request, 'Staff/view-complaints.html', {'val': obj, 'sr': search}) 


def search_feedback_staff(request):
    search = request.POST['search']
    obj = feedback_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_feedback_staff#about"</script>''')
    else:
        return render(request, 'Staff/view-feedback.html', {'val': obj, 'sr': search})             


def search_application(request):
    search = request.POST['search']
    obj = application_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_application#about"</script>''')

    else:
        return render(request, 'Staff/view-application.html', {'val': obj, 'sr': search})


def search_audit_staff(request):
    search = request.POST['search']
    obj = auditCourse_table.objects.filter(name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/audit_course_staff#about"</script>''')

    else:
        return render(request, 'Staff/audit-course.html', {'val': obj, 'sr': search})


def search_student(request):
    search = request.POST['search']
    obj = result_table.objects.filter(STUDENT__name__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_result#about"</script>''')

    else:
        return render(request, 'Staff/view-result.html', {'val': obj, 'sr': search})


def search_program_staff(request):
    search = request.POST['search']
    obj = program_table.objects.filter(date__istartswith=search)
    if len(obj) == 0:
        return HttpResponse('''<script>alert("no result found");window.location="/view_programs#about"</script>''')
    else:
        return render(request, 'Staff/view-programs.html', {'val': obj, 'sr': search})


def search_audit_questions_staff(request):
    id=request.session['audit_id']
    sr=request.POST['search']
    obj = QuestionsAndAnswers_table.objects.filter(AUDIT_COURSE__id=id,question__startswith=sr)
    audit = auditCourse_table.objects.get(id=id)
    return render(request,'Staff/manage-audit-questions.html',{'val':obj,'name':audit.name,"sr":sr})





def view_complaints_staff(request):
    obj = complaints_table.objects.filter(STUDENT__COURSE__id=request.session['log_cid'])
    return render(request,'Staff/view-complaints.html',{'val':obj})


def send_reply(request,id):
    request.session['complaint_id'] = id
    return  render(request,'Staff/send-reply.html')

def send_reply_post(request):
    reply = request.POST['reply']
    obj = complaints_table.objects.get(id=request.session['complaint_id'])  
    obj.reply = reply
    obj.save()  
    return HttpResponse('''<script>alert("success");window.location="/view_complaints_staff#about"</script>''')
    

def audit_course_staff(request):
    obj = auditCourse_table.objects.filter(COURSE__id=request.session['log_cid'])
    return render(request,'Staff/audit-course.html',{'val':obj})


def audit_questions_staff(request,id):
    request.session['audit_id'] = id
    obj = QuestionsAndAnswers_table.objects.filter(AUDIT_COURSE__id=id)
    audit = auditCourse_table.objects.get(id=id)
    return render(request,'Staff/manage-audit-questions.html',{'val':obj,'name':audit.name})

def view_application(request):
    obj = application_table.objects.filter(STUDENT__COURSE__id=request.session['log_cid'])
    return  render(request,'Staff/view-application.html',{'val':obj})




def accept_application(request,id):
    obj = application_table.objects.get(id=id)
    obj.status = 'accepted'
    obj.save()
    return HttpResponse('''<script>alert("success");window.location="/view_application#about"</script>''')

def reject_application(request,id):
    obj = application_table.objects.get(id=id)
    obj.status = 'rejected'
    obj.save()
    return HttpResponse('''<script>alert("success");window.location="/view_application#about"</script>''')





def view_feedback_staff(request):
    obj = feedback_table.objects.filter(STUDENT__COURSE__id=request.session['log_cid'])
    return  render(request,'Staff/view-feedback.html',{'val':obj})

def view_programs(request):
    obj = program_table.objects.all()
    return  render(request, 'Staff/view-programs.html',{'val':obj})


def view_students_staff(request):
    obj = student_table.objects.filter(COURSE_id=request.session['log_cid'])
    return  render(request,'Staff/view-students.html',{'val':obj})

def view_result(request):
    obj = result_table.objects.filter(STUDENT__COURSE__id=request.session['log_cid'])
    return  render(request,'Staff/view-result.html',{'val':obj})