BEGIN TRANSACTION;
CREATE TABLE "MeetingAttendees" ("MeetingID" INT  NOT NULL  ,"AttendeeID" INT  NOT NULL  ,PRIMARY KEY ("MeetingID","AttendeeID"),CONSTRAINT `FK_MeetingAtendee_Meeting` FOREIGN KEY (`MeetingID`) REFERENCES Meetings (`MeetingID`) ON DELETE NO ACTION ON UPDATE NO ACTION);
INSERT INTO `MeetingAttendees` VALUES (2,2);
INSERT INTO `MeetingAttendees` VALUES (3,1);
INSERT INTO `MeetingAttendees` VALUES (3,2);
INSERT INTO `MeetingAttendees` VALUES (4,1);
INSERT INTO `MeetingAttendees` VALUES (4,2);
INSERT INTO `MeetingAttendees` VALUES (4,3);
INSERT INTO `MeetingAttendees` VALUES (5,2);
INSERT INTO `MeetingAttendees` VALUES (5,3);
INSERT INTO `MeetingAttendees` VALUES (7,1);
INSERT INTO `MeetingAttendees` VALUES (7,2);
INSERT INTO `MeetingAttendees` VALUES (8,1);
INSERT INTO `MeetingAttendees` VALUES (8,2);
INSERT INTO `MeetingAttendees` VALUES (9,1);
INSERT INTO `MeetingAttendees` VALUES (9,2);
INSERT INTO `MeetingAttendees` VALUES (10,1);
INSERT INTO `MeetingAttendees` VALUES (10,3);
INSERT INTO `MeetingAttendees` VALUES (11,1);
INSERT INTO `MeetingAttendees` VALUES (11,3);
INSERT INTO `MeetingAttendees` VALUES (12,1);
INSERT INTO `MeetingAttendees` VALUES (12,3);
INSERT INTO `MeetingAttendees` VALUES (13,1);
INSERT INTO `MeetingAttendees` VALUES (13,2);
INSERT INTO `MeetingAttendees` VALUES (14,3);
INSERT INTO `MeetingAttendees` VALUES (15,3);
INSERT INTO `MeetingAttendees` VALUES (16,1);
INSERT INTO `MeetingAttendees` VALUES (17,2);
INSERT INTO `MeetingAttendees` VALUES (18,1);
INSERT INTO `MeetingAttendees` VALUES (18,2);
INSERT INTO `MeetingAttendees` VALUES (18,3);
INSERT INTO `MeetingAttendees` VALUES (19,1);
INSERT INTO `MeetingAttendees` VALUES (19,2);
INSERT INTO `MeetingAttendees` VALUES (20,1);
INSERT INTO `MeetingAttendees` VALUES (20,3);
INSERT INTO `MeetingAttendees` VALUES (21,3);
INSERT INTO `MeetingAttendees` VALUES (22,1);
INSERT INTO `MeetingAttendees` VALUES (22,2);
INSERT INTO `MeetingAttendees` VALUES (22,3);
INSERT INTO `MeetingAttendees` VALUES (23,2);
INSERT INTO `MeetingAttendees` VALUES (24,1);
INSERT INTO `MeetingAttendees` VALUES (24,2);
INSERT INTO `MeetingAttendees` VALUES (25,1);
INSERT INTO `MeetingAttendees` VALUES (26,2);
INSERT INTO `MeetingAttendees` VALUES (27,1);
INSERT INTO `MeetingAttendees` VALUES (27,2);
INSERT INTO `MeetingAttendees` VALUES (27,3);
INSERT INTO `MeetingAttendees` VALUES (28,3);
INSERT INTO `MeetingAttendees` VALUES (29,2);
INSERT INTO `MeetingAttendees` VALUES (29,3);
INSERT INTO `MeetingAttendees` VALUES (30,1);
INSERT INTO `MeetingAttendees` VALUES (31,2);
INSERT INTO `MeetingAttendees` VALUES (32,3);
INSERT INTO `MeetingAttendees` VALUES (33,2);
INSERT INTO `MeetingAttendees` VALUES (34,1);
INSERT INTO `MeetingAttendees` VALUES (35,3);
INSERT INTO `MeetingAttendees` VALUES (36,1);
INSERT INTO `MeetingAttendees` VALUES (36,2);
INSERT INTO `MeetingAttendees` VALUES (36,3);
INSERT INTO `MeetingAttendees` VALUES (37,1);
INSERT INTO `MeetingAttendees` VALUES (37,2);
INSERT INTO `MeetingAttendees` VALUES (37,3);
INSERT INTO `MeetingAttendees` VALUES (38,1);
COMMIT;