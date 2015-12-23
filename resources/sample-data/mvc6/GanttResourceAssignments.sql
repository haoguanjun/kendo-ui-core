BEGIN TRANSACTION;
CREATE TABLE "GanttResourceAssignments" ("ID" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  ,"TaskID" INT  NOT NULL  ,"ResourceID" INT  NOT NULL  ,"Units" FLOAT(5,2)  NOT NULL  );
INSERT INTO `GanttResourceAssignments` VALUES (1,7,1,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (2,18,1,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (3,11,14,0.5);
INSERT INTO `GanttResourceAssignments` VALUES (4,19,2,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (5,20,3,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (6,39,4,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (7,39,16,0.2);
INSERT INTO `GanttResourceAssignments` VALUES (8,39,15,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (9,12,15,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (10,12,16,0.25);
INSERT INTO `GanttResourceAssignments` VALUES (11,22,5,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (12,23,6,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (13,13,16,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (14,13,17,0.5);
INSERT INTO `GanttResourceAssignments` VALUES (15,24,7,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (16,26,8,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (17,27,9,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (18,29,6,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (19,28,10,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (20,14,17,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (21,32,10,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (22,33,11,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (23,30,18,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (24,34,12,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (25,35,13,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (26,31,15,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (27,31,18,0.5);
INSERT INTO `GanttResourceAssignments` VALUES (28,31,16,0.25);
INSERT INTO `GanttResourceAssignments` VALUES (29,36,12,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (30,37,5,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (31,38,7,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (32,17,1,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (33,17,15,0.2);
INSERT INTO `GanttResourceAssignments` VALUES (34,17,18,0.5);
INSERT INTO `GanttResourceAssignments` VALUES (35,17,17,1.0);
INSERT INTO `GanttResourceAssignments` VALUES (36,17,16,0.5);
INSERT INTO `GanttResourceAssignments` VALUES (37,17,14,1.0);
COMMIT;