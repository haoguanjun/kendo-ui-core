BEGIN TRANSACTION;
CREATE TABLE "OrgChartConnections" ("Id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL  ,"FromShapeId" INT  NULL DEFAULT NULL ,"ToShapeId" INT  NULL DEFAULT NULL ,"Text" TEXT  NULL  ,"FromPointX" INT  NULL DEFAULT NULL ,"FromPointY" INT  NULL DEFAULT NULL ,"ToPointX" INT  NULL DEFAULT NULL ,"ToPointY" INT  NULL DEFAULT NULL );
INSERT INTO `OrgChartConnections` VALUES (1,1,2,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (2,1,3,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (3,1,4,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (4,2,5,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (5,2,6,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (6,3,7,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (7,3,8,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (8,4,9,NULL,NULL,NULL,NULL,NULL);
INSERT INTO `OrgChartConnections` VALUES (9,4,10,NULL,NULL,NULL,NULL,NULL);
COMMIT;