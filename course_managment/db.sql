/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 8.0.33 : Database - course_management
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`course_management` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `course_management`;

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add user',4,'add_user'),
(14,'Can change user',4,'change_user'),
(15,'Can delete user',4,'delete_user'),
(16,'Can view user',4,'view_user'),
(17,'Can add content type',5,'add_contenttype'),
(18,'Can change content type',5,'change_contenttype'),
(19,'Can delete content type',5,'delete_contenttype'),
(20,'Can view content type',5,'view_contenttype'),
(21,'Can add session',6,'add_session'),
(22,'Can change session',6,'change_session'),
(23,'Can delete session',6,'delete_session'),
(24,'Can view session',6,'view_session'),
(25,'Can add audit course_table',7,'add_auditcourse_table'),
(26,'Can change audit course_table',7,'change_auditcourse_table'),
(27,'Can delete audit course_table',7,'delete_auditcourse_table'),
(28,'Can view audit course_table',7,'view_auditcourse_table'),
(29,'Can add course_table',8,'add_course_table'),
(30,'Can change course_table',8,'change_course_table'),
(31,'Can delete course_table',8,'delete_course_table'),
(32,'Can view course_table',8,'view_course_table'),
(33,'Can add login_table',9,'add_login_table'),
(34,'Can change login_table',9,'change_login_table'),
(35,'Can delete login_table',9,'delete_login_table'),
(36,'Can view login_table',9,'view_login_table'),
(37,'Can add notification_table',10,'add_notification_table'),
(38,'Can change notification_table',10,'change_notification_table'),
(39,'Can delete notification_table',10,'delete_notification_table'),
(40,'Can view notification_table',10,'view_notification_table'),
(41,'Can add program_table',11,'add_program_table'),
(42,'Can change program_table',11,'change_program_table'),
(43,'Can delete program_table',11,'delete_program_table'),
(44,'Can view program_table',11,'view_program_table'),
(45,'Can add subject_table',12,'add_subject_table'),
(46,'Can change subject_table',12,'change_subject_table'),
(47,'Can delete subject_table',12,'delete_subject_table'),
(48,'Can view subject_table',12,'view_subject_table'),
(49,'Can add student_table',13,'add_student_table'),
(50,'Can change student_table',13,'change_student_table'),
(51,'Can delete student_table',13,'delete_student_table'),
(52,'Can view student_table',13,'view_student_table'),
(53,'Can add staff_table',14,'add_staff_table'),
(54,'Can change staff_table',14,'change_staff_table'),
(55,'Can delete staff_table',14,'delete_staff_table'),
(56,'Can view staff_table',14,'view_staff_table'),
(57,'Can add result_table',15,'add_result_table'),
(58,'Can change result_table',15,'change_result_table'),
(59,'Can delete result_table',15,'delete_result_table'),
(60,'Can view result_table',15,'view_result_table'),
(61,'Can add questions and answers_table',16,'add_questionsandanswers_table'),
(62,'Can change questions and answers_table',16,'change_questionsandanswers_table'),
(63,'Can delete questions and answers_table',16,'delete_questionsandanswers_table'),
(64,'Can view questions and answers_table',16,'view_questionsandanswers_table'),
(65,'Can add qp_table',17,'add_qp_table'),
(66,'Can change qp_table',17,'change_qp_table'),
(67,'Can delete qp_table',17,'delete_qp_table'),
(68,'Can view qp_table',17,'view_qp_table'),
(69,'Can add notes_table',18,'add_notes_table'),
(70,'Can change notes_table',18,'change_notes_table'),
(71,'Can delete notes_table',18,'delete_notes_table'),
(72,'Can view notes_table',18,'view_notes_table'),
(73,'Can add news and events_table',19,'add_newsandevents_table'),
(74,'Can change news and events_table',19,'change_newsandevents_table'),
(75,'Can delete news and events_table',19,'delete_newsandevents_table'),
(76,'Can view news and events_table',19,'view_newsandevents_table'),
(77,'Can add feedback_table',20,'add_feedback_table'),
(78,'Can change feedback_table',20,'change_feedback_table'),
(79,'Can delete feedback_table',20,'delete_feedback_table'),
(80,'Can view feedback_table',20,'view_feedback_table'),
(81,'Can add complaints_table',21,'add_complaints_table'),
(82,'Can change complaints_table',21,'change_complaints_table'),
(83,'Can delete complaints_table',21,'delete_complaints_table'),
(84,'Can view complaints_table',21,'view_complaints_table'),
(85,'Can add application_table',22,'add_application_table'),
(86,'Can change application_table',22,'change_application_table'),
(87,'Can delete application_table',22,'delete_application_table'),
(88,'Can view application_table',22,'view_application_table'),
(89,'Can add allocate_table',23,'add_allocate_table'),
(90,'Can change allocate_table',23,'change_allocate_table'),
(91,'Can delete allocate_table',23,'delete_allocate_table'),
(92,'Can view allocate_table',23,'view_allocate_table'),
(93,'Can add open_course_table',24,'add_open_course_table'),
(94,'Can change open_course_table',24,'change_open_course_table'),
(95,'Can delete open_course_table',24,'delete_open_course_table'),
(96,'Can view open_course_table',24,'view_open_course_table');

/*Table structure for table `auth_user` */

DROP TABLE IF EXISTS `auth_user`;

CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user` */

insert  into `auth_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`) values 
(1,'pbkdf2_sha256$260000$Xpt1zxHN8gHVnzN19nQVLP$uoUwWYOVG0wwSyhy5GvOsCjED4k3Qpj4DxbyFAwgNRU=','2024-01-23 12:09:35.798150',1,'admin','','','admin@gmail.com',1,1,'2024-01-23 11:43:53.418168');

/*Table structure for table `auth_user_groups` */

DROP TABLE IF EXISTS `auth_user_groups`;

CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_groups` */

/*Table structure for table `auth_user_user_permissions` */

DROP TABLE IF EXISTS `auth_user_user_permissions`;

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `auth_user_user_permissions` */

/*Table structure for table `course_management_app_allocate_table` */

DROP TABLE IF EXISTS `course_management_app_allocate_table`;

CREATE TABLE `course_management_app_allocate_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `STAFF_id` bigint NOT NULL,
  `SUBJECT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_STAFF_id_8ad57fed_fk_course_ma` (`STAFF_id`),
  KEY `course_management_ap_SUBJECT_id_2dec85d4_fk_course_ma` (`SUBJECT_id`),
  CONSTRAINT `course_management_ap_STAFF_id_8ad57fed_fk_course_ma` FOREIGN KEY (`STAFF_id`) REFERENCES `course_management_app_staff_table` (`id`),
  CONSTRAINT `course_management_ap_SUBJECT_id_2dec85d4_fk_course_ma` FOREIGN KEY (`SUBJECT_id`) REFERENCES `course_management_app_subject_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_allocate_table` */

insert  into `course_management_app_allocate_table`(`id`,`date`,`STAFF_id`,`SUBJECT_id`) values 
(6,'2024-01-08',6,9),
(8,'2024-01-08',7,12);

/*Table structure for table `course_management_app_application_table` */

DROP TABLE IF EXISTS `course_management_app_application_table`;

CREATE TABLE `course_management_app_application_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `COURSE_id` bigint NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_COURSE_id_98ff7342_fk_course_ma` (`COURSE_id`),
  KEY `course_management_ap_STUDENT_id_f348c12f_fk_course_ma` (`STUDENT_id`),
  CONSTRAINT `course_management_ap_COURSE_id_98ff7342_fk_course_ma` FOREIGN KEY (`COURSE_id`) REFERENCES `course_management_app_course_table` (`id`),
  CONSTRAINT `course_management_ap_STUDENT_id_f348c12f_fk_course_ma` FOREIGN KEY (`STUDENT_id`) REFERENCES `course_management_app_student_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_application_table` */

insert  into `course_management_app_application_table`(`id`,`date`,`status`,`COURSE_id`,`STUDENT_id`) values 
(4,'2024-01-21','accepted',5,2),
(5,'2024-01-17','pending',6,2),
(6,'2024-01-21','pending',6,3);

/*Table structure for table `course_management_app_auditcourse_table` */

DROP TABLE IF EXISTS `course_management_app_auditcourse_table`;

CREATE TABLE `course_management_app_auditcourse_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `sem` varchar(50) NOT NULL,
  `COURSE_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_COURSE_id_87b29b98_fk_course_ma` (`COURSE_id`),
  CONSTRAINT `course_management_ap_COURSE_id_87b29b98_fk_course_ma` FOREIGN KEY (`COURSE_id`) REFERENCES `course_management_app_course_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_auditcourse_table` */

insert  into `course_management_app_auditcourse_table`(`id`,`name`,`sem`,`COURSE_id`) values 
(5,'disaster','3',5),
(6,'human rigths','4',5),
(7,'bussienes','3',6);

/*Table structure for table `course_management_app_complaints_table` */

DROP TABLE IF EXISTS `course_management_app_complaints_table`;

CREATE TABLE `course_management_app_complaints_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `complaint` longtext NOT NULL,
  `date` date NOT NULL,
  `reply` longtext NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_STUDENT_id_b0b3aba7_fk_course_ma` (`STUDENT_id`),
  CONSTRAINT `course_management_ap_STUDENT_id_b0b3aba7_fk_course_ma` FOREIGN KEY (`STUDENT_id`) REFERENCES `course_management_app_student_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_complaints_table` */

insert  into `course_management_app_complaints_table`(`id`,`complaint`,`date`,`reply`,`STUDENT_id`) values 
(4,'complaint 1','2024-01-28','replalu',2),
(5,'sfgfdgsd','2024-01-22','pending',2),
(6,'yhyfyfhfhfhf','2024-01-22','pending',3);

/*Table structure for table `course_management_app_course_table` */

DROP TABLE IF EXISTS `course_management_app_course_table`;

CREATE TABLE `course_management_app_course_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `duration` varchar(50) NOT NULL,
  `details` longtext NOT NULL,
  `fees` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_course_table` */

insert  into `course_management_app_course_table`(`id`,`name`,`duration`,`details`,`fees`) values 
(5,'BCA','6','adads',30000),
(6,'BBA','5','simple',300),
(8,'Bcom','dfg','sf',22222);

/*Table structure for table `course_management_app_feedback_table` */

DROP TABLE IF EXISTS `course_management_app_feedback_table`;

CREATE TABLE `course_management_app_feedback_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `feedback` longtext NOT NULL,
  `date` date NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_STUDENT_id_c0d3c113_fk_course_ma` (`STUDENT_id`),
  CONSTRAINT `course_management_ap_STUDENT_id_c0d3c113_fk_course_ma` FOREIGN KEY (`STUDENT_id`) REFERENCES `course_management_app_student_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_feedback_table` */

insert  into `course_management_app_feedback_table`(`id`,`feedback`,`date`,`STUDENT_id`) values 
(3,'feedback 1','2024-01-22',2),
(4,'adfd','2024-01-11',2);

/*Table structure for table `course_management_app_login_table` */

DROP TABLE IF EXISTS `course_management_app_login_table`;

CREATE TABLE `course_management_app_login_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(20) NOT NULL,
  `type` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_login_table` */

insert  into `course_management_app_login_table`(`id`,`username`,`password`,`type`) values 
(1,'admin','admin','admin'),
(7,'student','student','student'),
(8,'teacher','teacher','staff'),
(9,'staff','staff','staff'),
(10,'s1','s1','staff'),
(12,'student1','student1','student'),
(14,'RAMESH','RAMESH','staff');

/*Table structure for table `course_management_app_newsandevents_table` */

DROP TABLE IF EXISTS `course_management_app_newsandevents_table`;

CREATE TABLE `course_management_app_newsandevents_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `news_events` varchar(50) NOT NULL,
  `image` varchar(100) NOT NULL,
  `details` longtext NOT NULL,
  `date` date NOT NULL,
  `STAFF_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_STAFF_id_1f9fdb81_fk_course_ma` (`STAFF_id`),
  CONSTRAINT `course_management_ap_STAFF_id_1f9fdb81_fk_course_ma` FOREIGN KEY (`STAFF_id`) REFERENCES `course_management_app_staff_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_newsandevents_table` */

insert  into `course_management_app_newsandevents_table`(`id`,`news_events`,`image`,`details`,`date`,`STAFF_id`) values 
(10,'new1','360_F_298479305_ZhuAn19ynHNfcEEff58bINpwkZHAXz7w-removebg-preview_gBARIMR.png','fffff','2024-01-24',6),
(11,'drrrrrr','360_F_298479305_ZhuAn19ynHNfcEEff58bINpwkZHAXz7w-removebg-preview_YGMycIo_Ft78hKo_3mvLYYg.png','frddty','2024-01-10',7);

/*Table structure for table `course_management_app_notes_table` */

DROP TABLE IF EXISTS `course_management_app_notes_table`;

CREATE TABLE `course_management_app_notes_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `title` varchar(50) NOT NULL,
  `note` varchar(100) NOT NULL,
  `SUBJECT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_SUBJECT_id_0f152b36_fk_course_ma` (`SUBJECT_id`),
  CONSTRAINT `course_management_ap_SUBJECT_id_0f152b36_fk_course_ma` FOREIGN KEY (`SUBJECT_id`) REFERENCES `course_management_app_subject_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_notes_table` */

insert  into `course_management_app_notes_table`(`id`,`date`,`title`,`note`,`SUBJECT_id`) values 
(3,'2024-01-28','note','note.pdf',9);

/*Table structure for table `course_management_app_notification_table` */

DROP TABLE IF EXISTS `course_management_app_notification_table`;

CREATE TABLE `course_management_app_notification_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `notification` longtext NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_notification_table` */

insert  into `course_management_app_notification_table`(`id`,`notification`,`date`) values 
(3,'asdfasdf','2023-12-21'),
(4,'xcvbbfg','2024-01-05'),
(6,'nnnnnnnnnnnnnnnnnnnnnnnn','2024-01-08'),
(7,'pppp','2024-01-08');

/*Table structure for table `course_management_app_open_course_table` */

DROP TABLE IF EXISTS `course_management_app_open_course_table`;

CREATE TABLE `course_management_app_open_course_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `COURSE_id` bigint NOT NULL,
  `SUBJECT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_COURSE_id_0d912d99_fk_course_ma` (`COURSE_id`),
  KEY `course_management_ap_SUBJECT_id_ac8e9722_fk_course_ma` (`SUBJECT_id`),
  CONSTRAINT `course_management_ap_COURSE_id_0d912d99_fk_course_ma` FOREIGN KEY (`COURSE_id`) REFERENCES `course_management_app_course_table` (`id`),
  CONSTRAINT `course_management_ap_SUBJECT_id_ac8e9722_fk_course_ma` FOREIGN KEY (`SUBJECT_id`) REFERENCES `course_management_app_subject_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_open_course_table` */

insert  into `course_management_app_open_course_table`(`id`,`COURSE_id`,`SUBJECT_id`) values 
(13,5,6),
(16,6,8),
(17,6,9);

/*Table structure for table `course_management_app_program_table` */

DROP TABLE IF EXISTS `course_management_app_program_table`;

CREATE TABLE `course_management_app_program_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `details` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `photo` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_program_table` */

insert  into `course_management_app_program_table`(`id`,`name`,`details`,`date`,`photo`) values 
(3,'p1','a sample program','2023-12-21','Image 10.jpg'),
(4,'event1','a sample event','2024-01-09','istockphoto-176851361-612x612-removebg-preview_5TJS0a0.png');

/*Table structure for table `course_management_app_qp_table` */

DROP TABLE IF EXISTS `course_management_app_qp_table`;

CREATE TABLE `course_management_app_qp_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `year` varchar(20) NOT NULL,
  `qp` varchar(100) NOT NULL,
  `date` date NOT NULL,
  `SUBJECT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_SUBJECT_id_3da3acfe_fk_course_ma` (`SUBJECT_id`),
  CONSTRAINT `course_management_ap_SUBJECT_id_3da3acfe_fk_course_ma` FOREIGN KEY (`SUBJECT_id`) REFERENCES `course_management_app_subject_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_qp_table` */

insert  into `course_management_app_qp_table`(`id`,`title`,`year`,`qp`,`date`,`SUBJECT_id`) values 
(4,'qp1','2022','qp_WBQvxHA.pdf','2024-01-08',9),
(6,'uuyuu','343','qp_4hcj3Zn.pdf','2024-01-08',12);

/*Table structure for table `course_management_app_questionsandanswers_table` */

DROP TABLE IF EXISTS `course_management_app_questionsandanswers_table`;

CREATE TABLE `course_management_app_questionsandanswers_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `question` longtext NOT NULL,
  `option_1` varchar(50) NOT NULL,
  `option_2` varchar(50) NOT NULL,
  `option_3` varchar(50) NOT NULL,
  `option_4` varchar(50) NOT NULL,
  `answer` varchar(50) NOT NULL,
  `AUDIT_COURSE_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_AUDIT_COURSE_id_80ac0988_fk_course_ma` (`AUDIT_COURSE_id`),
  CONSTRAINT `course_management_ap_AUDIT_COURSE_id_80ac0988_fk_course_ma` FOREIGN KEY (`AUDIT_COURSE_id`) REFERENCES `course_management_app_auditcourse_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_questionsandanswers_table` */

insert  into `course_management_app_questionsandanswers_table`(`id`,`question`,`option_1`,`option_2`,`option_3`,`option_4`,`answer`,`AUDIT_COURSE_id`) values 
(11,'q1','aa','ss','ss','ss','ss',5),
(12,'ffdfd','dffd','dfd','fdff','dfd','df',5);

/*Table structure for table `course_management_app_result_table` */

DROP TABLE IF EXISTS `course_management_app_result_table`;

CREATE TABLE `course_management_app_result_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `mark` double NOT NULL,
  `AUDIT_COURSE_id` bigint NOT NULL,
  `STUDENT_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_AUDIT_COURSE_id_c82b16e8_fk_course_ma` (`AUDIT_COURSE_id`),
  KEY `course_management_ap_STUDENT_id_19e130ba_fk_course_ma` (`STUDENT_id`),
  CONSTRAINT `course_management_ap_AUDIT_COURSE_id_c82b16e8_fk_course_ma` FOREIGN KEY (`AUDIT_COURSE_id`) REFERENCES `course_management_app_auditcourse_table` (`id`),
  CONSTRAINT `course_management_ap_STUDENT_id_19e130ba_fk_course_ma` FOREIGN KEY (`STUDENT_id`) REFERENCES `course_management_app_student_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_result_table` */

insert  into `course_management_app_result_table`(`id`,`date`,`mark`,`AUDIT_COURSE_id`,`STUDENT_id`) values 
(1,'2024-01-10',45,6,2),
(2,'2024-01-21',33,7,3);

/*Table structure for table `course_management_app_staff_table` */

DROP TABLE IF EXISTS `course_management_app_staff_table`;

CREATE TABLE `course_management_app_staff_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `place` varchar(50) NOT NULL,
  `post` varchar(50) NOT NULL,
  `pin` bigint NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(50) NOT NULL,
  `COURSE_id` bigint NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_COURSE_id_ed78bef2_fk_course_ma` (`COURSE_id`),
  KEY `course_management_ap_LOGIN_id_9cf15050_fk_course_ma` (`LOGIN_id`),
  CONSTRAINT `course_management_ap_COURSE_id_ed78bef2_fk_course_ma` FOREIGN KEY (`COURSE_id`) REFERENCES `course_management_app_course_table` (`id`),
  CONSTRAINT `course_management_ap_LOGIN_id_9cf15050_fk_course_ma` FOREIGN KEY (`LOGIN_id`) REFERENCES `course_management_app_login_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_staff_table` */

insert  into `course_management_app_staff_table`(`id`,`name`,`photo`,`place`,`post`,`pin`,`phone`,`email`,`COURSE_id`,`LOGIN_id`) values 
(6,'sheheem','1842437WT3558.jpg','kottapadi','malappuram',111332,1113334535,'staff@gmail.com',5,9),
(7,'s1','student_lB1zUtC.png','malappuram','malappuram',11133,22222,'s1@gmail.com',6,10),
(10,'afd','facebook.png','adf','adf',434344,3343243423,'GMA@Y',5,14);

/*Table structure for table `course_management_app_student_table` */

DROP TABLE IF EXISTS `course_management_app_student_table`;

CREATE TABLE `course_management_app_student_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `photo` varchar(100) NOT NULL,
  `place` varchar(50) NOT NULL,
  `post` varchar(50) NOT NULL,
  `pin` int NOT NULL,
  `phone` bigint NOT NULL,
  `email` varchar(254) NOT NULL,
  `sem` varchar(20) NOT NULL,
  `COURSE_id` bigint NOT NULL,
  `LOGIN_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_COURSE_id_053ffbb8_fk_course_ma` (`COURSE_id`),
  KEY `course_management_ap_LOGIN_id_dca2d96b_fk_course_ma` (`LOGIN_id`),
  CONSTRAINT `course_management_ap_COURSE_id_053ffbb8_fk_course_ma` FOREIGN KEY (`COURSE_id`) REFERENCES `course_management_app_course_table` (`id`),
  CONSTRAINT `course_management_ap_LOGIN_id_dca2d96b_fk_course_ma` FOREIGN KEY (`LOGIN_id`) REFERENCES `course_management_app_login_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_student_table` */

insert  into `course_management_app_student_table`(`id`,`name`,`photo`,`place`,`post`,`pin`,`phone`,`email`,`sem`,`COURSE_id`,`LOGIN_id`) values 
(2,'km ashik','km.jpg','kottumala','Oorakam',676519,9539483055,'kmashiqu@gmail.com','6',5,7),
(3,'student1','photo.jpg','calicut','calicut',48965,8569855,'std@gmail.com','5',6,12);

/*Table structure for table `course_management_app_subject_table` */

DROP TABLE IF EXISTS `course_management_app_subject_table`;

CREATE TABLE `course_management_app_subject_table` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` longtext NOT NULL,
  `sem` varchar(20) NOT NULL,
  `COURSE_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_management_ap_COURSE_id_6bbf954a_fk_course_ma` (`COURSE_id`),
  CONSTRAINT `course_management_ap_COURSE_id_6bbf954a_fk_course_ma` FOREIGN KEY (`COURSE_id`) REFERENCES `course_management_app_course_table` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `course_management_app_subject_table` */

insert  into `course_management_app_subject_table`(`id`,`name`,`description`,`sem`,`COURSE_id`) values 
(6,'ecommerce','asdfikj','5',NULL),
(8,'physical','adfasfdaf','5',NULL),
(9,'java','ddddd','3',5),
(12,'bussiness management','simple','3',6),
(14,'computer','dd','dd',5);

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(1,'admin','logentry'),
(3,'auth','group'),
(2,'auth','permission'),
(4,'auth','user'),
(5,'contenttypes','contenttype'),
(23,'course_management_app','allocate_table'),
(22,'course_management_app','application_table'),
(7,'course_management_app','auditcourse_table'),
(21,'course_management_app','complaints_table'),
(8,'course_management_app','course_table'),
(20,'course_management_app','feedback_table'),
(9,'course_management_app','login_table'),
(19,'course_management_app','newsandevents_table'),
(18,'course_management_app','notes_table'),
(10,'course_management_app','notification_table'),
(24,'course_management_app','open_course_table'),
(11,'course_management_app','program_table'),
(17,'course_management_app','qp_table'),
(16,'course_management_app','questionsandanswers_table'),
(15,'course_management_app','result_table'),
(14,'course_management_app','staff_table'),
(13,'course_management_app','student_table'),
(12,'course_management_app','subject_table'),
(6,'sessions','session');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2023-12-20 09:43:36.823671'),
(2,'auth','0001_initial','2023-12-20 09:43:40.276541'),
(3,'admin','0001_initial','2023-12-20 09:43:40.964076'),
(4,'admin','0002_logentry_remove_auto_add','2023-12-20 09:43:40.995329'),
(5,'admin','0003_logentry_add_action_flag_choices','2023-12-20 09:43:41.026581'),
(6,'contenttypes','0002_remove_content_type_name','2023-12-20 09:43:41.354723'),
(7,'auth','0002_alter_permission_name_max_length','2023-12-20 09:43:41.604735'),
(8,'auth','0003_alter_user_email_max_length','2023-12-20 09:43:41.729740'),
(9,'auth','0004_alter_user_username_opts','2023-12-20 09:43:41.792250'),
(10,'auth','0005_alter_user_last_login_null','2023-12-20 09:43:42.120388'),
(11,'auth','0006_require_contenttypes_0002','2023-12-20 09:43:42.136039'),
(12,'auth','0007_alter_validators_add_error_messages','2023-12-20 09:43:42.182891'),
(13,'auth','0008_alter_user_username_max_length','2023-12-20 09:43:42.479780'),
(14,'auth','0009_alter_user_last_name_max_length','2023-12-20 09:43:42.745420'),
(15,'auth','0010_alter_group_name_max_length','2023-12-20 09:43:42.823556'),
(16,'auth','0011_update_proxy_permissions','2023-12-20 09:43:42.886051'),
(17,'auth','0012_alter_user_first_name_max_length','2023-12-20 09:43:43.198568'),
(18,'course_management_app','0001_initial','2023-12-20 09:43:53.258330'),
(19,'sessions','0001_initial','2023-12-20 09:43:53.633368'),
(20,'course_management_app','0002_alter_notes_table_note','2023-12-21 04:51:26.388789'),
(21,'course_management_app','0003_alter_qp_table_year','2023-12-21 05:13:23.929178'),
(22,'course_management_app','0004_open_course_table','2024-01-05 05:28:00.834690'),
(23,'course_management_app','0005_alter_subject_table_course','2024-01-05 05:40:48.530156');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('5vohrvx14bh38u7pqb9axk4dff4mahw2','.eJyrViouSUxLi89MUbKy0FFKzi8tKk4F8wx1lIpLk7JSk0vAXDMdpcICMMtYRykvtbwYxk7Ozy3ISczMgygz0lHKgZqVWJqSCRfMyy-BGGtUCwCAtCT6:1rLhPo:SzCc78zToqou5MypiKro8NB5olPnB-H2C5ER_jz_jgE','2024-01-19 10:27:00.965586'),
('o57znxr715r1w17xvbsaw0o7n3mcqlta','.eJxVjrsOwjAUQ_8lcxUl5M3IzjdUubnpC2hQkk6If6ctHWC0j235RVq_1KFdSsztiORMOGl-PfDhFucN4OTnPtGQ5ppHoFuEHrTQa8J4vxzZv4HBl2FtgwpMYQBnFO-kZIjCWe5QnJiyKLUJyLgTYAM7aSvBggIdPZNcMG_M9qpU33X7Sd2QZ0599o9dypUtMMVQv_T9AT8MRSQ:1rSFgA:EppJijpnnKCAWl-HZfGfxE8TFb_JV2blEYAbYvSHkfU','2024-02-06 12:14:58.990855'),
('oikc37ai8lmyu00t13vyztfvtej361fi','eyJzdGFmZl9pZCI6M30:1rGHIg:vAaqXjKuU95C3ZQo8AdOCNsI0b0gMJPJra0BZdAiHCw','2024-01-04 11:33:14.576444'),
('p7iuk1imkun79pkd74kajrp04csxagi7','.eJxVjEtygzAQRO-iNUVJSALJy-x9Bmo0Iz62g2x9KotU7h4wsPBqpl6_7l8Ghebcz8QuumKP7dqKpQzD8IZtxTCUmPyppOJuHveGaCr2ep7eEvJuyfX3P2lX-Loaxh6P-jOGMcL36fVQ8tSX5OObMME-mAO8-2UL6AbLGGoMS46zqzelPtJUXwP5x9fhfgxMkKa17TRyTehsp8WgFCeS1ghLsuHakGo7JC6sdAZ50xrljNOu9cCVkBy6TrC_fxZSXno:1rSFNz:a_wC-RnZhl-fwKUqzGtCErUYQIHSTtNiufgYHCCoSFs','2024-02-06 11:56:11.401210'),
('wkw8o3qdb02e6vfovy9f71gicu1mvakc','eyJsaWQiOjksImxvZ19jaWQiOjV9:1rQoYI:oCJgGL22h3TjU4vaaftJ7HWy6rhlTdM7zomqpoBpj7U','2024-02-02 13:04:54.203305');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
