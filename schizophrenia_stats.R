setwd("schizophrenia_results_dir")
ggplot(data=l,aes(x=Age, y=MeanThickness, colour=group))+geom_smooth(metho="lm")+geom_point()
%Results 1) Mean thickness differences
l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "CurvOxCaf")
m <- lme(MeanThickness ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
boxplot(MeanThickness ~ group*Hemi, data=l,col=(c("red","green")))
%Results 2) Gyral sulcal differences
l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "CurvOxCaf")
l$Diff <- l$GyralThickness - l$SulcalThickness
l$NormDiff <- l$Diff/l$MeanThickness
m <- glm(group ~ NormDiff + Hemi  + Gender + SurfaceArea,  data=l, family = "binomial")
m <- lme(GyralThickness ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
m <- lme(SulcalThickness ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
m <- lme(Diff ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
surfaceareas <- read.xlsx(file="SchizophreniaHierarchies.xlsx", sheetName= "Sheet2")
l$Length <- surfaceareas$Length.of.Illness[1:82]
l$Medication <- surfaceareas$Medication[1:82]
Med <- subset(l, Medication !="NA")
Med$Diff <- Med$GyralThickness - Med$SulcalThickness
m <- lme(Diff ~ Medication + Hemi + SurfaceArea + Gender + Age, random=~1 | fsid, data=Med)
summary(m)

%Results 3) Curvature differences
l <- read.xlsx(file="OxfordCafK.xlsx", sheetName= "Curvature")
m <- glm(group ~  PialSurfDiff + Hemi  + SurfaceArea + Age + Gender,  data=l, family = "binomial")
m <- lme(WhiteCurvGyral ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
m <- lme(WhiteCurvSulcal ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
m <- lme(PialCurvGyral ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
m <- lme(PialCurvSulcal ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
Controls <- subset(l, group=="control")
l$WhiteGyralNormCurv <- l$WhiteCurvGyral - mean(Controls$WhiteCurvGyral)
l$WhiteSulcalNormCurv <- l$WhiteCurvSulcal - mean(Controls$WhiteCurvSulcal)
l$PialGyralNormCurv <- l$PialCurvGyral - mean(Controls$PialCurvGyral)
l$PialSulcalNormCurv <- l$PialCurvSulcal - mean(Controls$PialCurvSulcal)
l$GyralSurfDiff <- l$WhiteCurvGyral - l$PialCurvGyral
l$SulcalSurfDiff <- l$WhiteCurvSulcal - l$PialCurvSulcal
l$PialSurfDiff <- l$PialCurvGyral - l$PialCurvSulcal
m <- lme(PialSurfDiff ~ group + Hemi + Gender + Age + SurfaceArea, random=~1 |fsid, data=l)
summary(m)
surfaceareas <- read.xlsx(file="SchizophreniaHierarchies.xlsx", sheetName= "Sheet2")
rh <- subset(l,Hemi=="rh")
lh <-subset(l,Hemi=="lh")
lh$Length <- surfaceareas$Length.of.Illness[1:82]
lh$Medication <- surfaceareas$Medication[1:82]
rh$Length <- surfaceareas$Length.of.Illness[1:82]
rh$Medication <- surfaceareas$Medication[1:82]
l <- rbind(rh,lh)
Med <- subset(l, Medication !="NA")
m <- lme(PialSurfDiff~ Medication + Hemi + SurfaceArea + Gender + Age, random=~1 | fsid, data=Med)
summary(m)
boxplot(GyralSurfDiff ~ group, data=l)
boxplot(SulcalSurfDiff ~ group, data=l)
boxplot(PialSurfDiff ~ group, data=l)
l <- read.xlsx(file="OxfordCafK.xlsx", sheetName= "Boxplot")
red1   <- rgb(255/255, 191/255, 127/255)
blue1   <- rgb(195/255, 250/255, 130/255)
red4   <- rgb(255/255, 127/255, 0/255)
blue4   <- rgb(195/255, 200/255, 0/255)
boxplot(NormCurv~group*Morph*Surface,data=l,col=(c(blue1,red1,blue1,red1,blue4, red4, blue4,red4)), at=c(1,2,3,4, 6,7,8,9), xlim=c(0.5,9.5), las=2)
k <- subset(l, Surface=="Pial")
boxplot(Curvature~group*Morph,data=k,col=(c(blue1,red1,blue1,red1)))
l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "GlobalCurvature")
m <- glm(Group ~  PialSkew + WhiteArea + Hemi,  data=l, family = "binomial")
summary(m)
boxplot(PialSkew~Group*Hemi, data=l,col=(c("red","green")))
boxplot(WhiteSkew~Group*Hemi, data=l, col=(c("red","green")))
%Results 4) a is qdec
%4b)
l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "LayerThicknessesRhoP")
ggplot(l, aes(x=Layer, y=Rho)) + geom_point(aes(colour=Layer), shape=3) 
l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "LayerThicknessData")
b <- subset(l, Layer =="II")
l <-subset(l,Layer!="Total")
ggplot(b, aes(x=Thickness, y=GSD))+ geom_smooth(method="lm", aes(colour=Layer,linetype=Layer)) +geom_point()  + theme_bw(20)+ opts(panel.grid.major = theme_blank(), panel.grid.minor = theme_blank())
fill=NA,

m <- lm(GSD ~ Thickness + Hemi,  data=b)
summary(m)
%Results 5)
ox <- read.xlsx(file="SchizophreniaHierarchies.xlsx", sheetName= "Sheet1")

surfaceareas <- read.xlsx(file="SchizophreniaHierarchies.xlsx", sheetName= "Sheet2")
ox$Log <- log(ox$Thickness)
ggplot(data=ox, aes(x=Hierarchy, y=Thickness, linetype=Hemi, colour=group,aes(col=(c(blue1,red1))))) +geom_smooth(method="lm") + geom_point() +theme_bw(20) + scale_colour_manual(values=c("#C3C800","#FF7F00"))
Left <- subset(ox,Hemi =="lh")
%Left <- subset(Left, Hierarchy != 6)
m <- lmer(Thickness ~ Hierarchy + (Hierarchy|fsid), data=Left)
summary(m)
A <- coef(m)$fsid
A$group[40:82] <- 'patient'
A$group[1:39] <- 'control'
A$fsid <- unique(Left$fsid)
A$Hemi[1:82] <- 'lh'
A$SA <- surfaceareas$SurfaceArea[1:82]
A$Length <- surfaceareas$Length.of.Illness[1:82]
A$Medication <- surfaceareas$Medication[1:82]
Right <- subset(ox,Hemi =="rh")
%Right <- subset(Right, Hierarchy !=6)
m <- lmer(Thickness ~ Hierarchy + (Hierarchy|fsid), data=Right)
B <- coef(m)$fsid
B$group[40:82] <- 'patient'
B$group[1:39] <- 'control'
B$fsid <- unique(Left$fsid)
B$Hemi[1:82] <- 'rh'
B$SA <- surfaceareas$SurfaceArea[83:164]
B$Length <- surfaceareas$Length.of.Illness[1:82]
B$Medication <- surfaceareas$Medication[1:82]
C <- rbind(A,B)
C$Age <- l$Age
C$Gender <- l$Gender
P <- lme(Hierarchy ~ group + Hemi + SA + Age + Gender, random=~1 | fsid, data=C)
summary(P)
LeftC <- (subset(C,group=="control" & Hemi=="lh"))
MeanL <- mean(LeftC$Hierarchy)
SDL <- sd(LeftC$Hierarchy)
RightC <- (subset(C,group=="control" & Hemi=="rh"))
MeanR <- mean(RightC$Hierarchy)
SDR <- sd(RightC$Hierarchy)
B$Hierarchy <- (B$Hierarchy - MeanR)/SDR
A$Hierarchy <- (A$Hierarchy - MeanL)/SDL
C <- rbind(A,B)
boxplot(Hierarchy~group*Hemi, data=C,col=(c(blue1,red1)) )
summary(m)
boxplot(Diff ~ group*Hemi, data=l)

ox <- read.xlsx(file="SchizophreniaHierarchies.xlsx", sheetName= "Sheet1")
m <- lme(MeanThickness ~ group + Hemi + Gender + Age + Surface.Area, random=~1 |fsid, data=ox)
summary(m)

surfaceareas <- read.xlsx(file="SchizophreniaHierarchies.xlsx", sheetName= "Sheet2")
ggplot(data=ox, aes(x=Hierarchy, y=Thickness, linetype=Hemi, colour=group)) +geom_smooth(method="lm") + geom_point() +theme_bw(20) +opts(title ="Cortical thickness gradient")
Left <- subset(ox,Hemi =="lh")
%Left <- subset(Left, Hierarchy != 6)
m <- lmer(Thickness ~ Hierarchy + (Hierarchy|fsid), data=Left)
summary(m)
A <- coef(m)$fsid
A$group[40:82] <- 'patient'
A$group[1:39] <- 'control'
A$fsid <- unique(Left$fsid)
A$Hemi[1:82] <- 'lh'
A$SA <- surfaceareas$SurfaceArea[1:82]
A$Length <- surfaceareas$Length.of.Illness[1:82]
A$Medication <- surfaceareas$Medication[1:82]
Right <- subset(ox,Hemi =="rh")
%Right <- subset(Right, Hierarchy !=6)
m <- lmer(Thickness ~ Hierarchy + (Hierarchy|fsid), data=Right)
B <- coef(m)$fsid
B$group[40:82] <- 'patient'
B$group[1:39] <- 'control'
B$fsid <- unique(Left$fsid)
B$Hemi[1:82] <- 'rh'
B$SA <- surfaceareas$SurfaceArea[83:164]
B$Length <- surfaceareas$Length.of.Illness[1:82]
B$Medication <- surfaceareas$Medication[1:82]



C <- rbind(A,B)
P <- lme(Hierarchy ~ group + Hemi + SA, random=~1 | fsid, data=C)
summary(P)
boxplot(Hierarchy~group*Hemi, data=C,col=(c("red","green")))
C$Age <- l$Age
C$Gender <- l$Gender
Patients <- subset(C, group="patients")
Patients <- subset(C, Medication!="NA")
Patients[is.na(Patients)] <- 0
M <- lme(Hierarchy ~ Length + Hemi + Age + Gender + SA, random=~1 | fsid, data=Patients)                                                                                                                                                           
summary(M)
Patients <- subset(surfaceareas, Length.of.Illness!="NA")
Patients <- na.omit(Patients)
m <- lme(MeanThickness ~ Length.of.Illness + Hemi + Age, random=~1 | fsid, data=Patients)
summary(m)
ggplot(data=Patients, aes(x=Medication,y=Hierarchy,linetype=Hemi, colour=Hemi))  +geom_smooth(method="lm") + geom_point() +theme_bw(20) +opts(title ="Cortical thickness gradient")
l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "CurvOxCaf")

l$Length <- surfaceareas$Length.of.Illness[1:82]
l$Medication <- surfaceareas$Medication[1:82]
Med <- subset(l, Medication !="NA")
Med$Diff <- Med$GyralThickness - Med$SulcalThickness
m <- lme(Diff ~ Medication + Hemi + SurfaceArea + Length, random=~1 | fsid, data=Med)
summary(m)
ggplot(data=Med, aes(x=Medication, y=Diff, linetype=Hemi))+geom_smooth(method="lm") + geom_point() + theme_bw(20)+ opts(panel.grid.major = theme_blank(), panel.grid.minor = theme_blank())


ggplot(data=Med, aes(x=Length, y=Diff, linetype=Hemi))+geom_smooth(method="lm") + geom_point()




A$row.names
A$Hierarchy
interaction.plot(Left$Hierarchy, Left$group, Left$Thickness)

GSK <- read.xlsx(file="SchizophreniaHierarchies.xlsx", sheetName= "Sheet3")
ggplot(data=GSK, aes(x=Hierarchy, y=Thickness, linetype=group)) +geom_smooth(method="loess") + geom_point() +theme_bw(20) +opts(title ="Somatosensory: Cortical thickness \nagainst geodesic distance")



Med <- subset(C, Medication!="NA")
ggplot(data=Med, aes(x=Medication, y=Hierarchy, linetype=Hemi))+geom_smooth(method="loess") + geom_point()
m <- lme(Hierarchy ~ Medication + Hemi + Length, random=~1 | fsid, data=Med)
summary(m)

l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "BoxplotOxCaf")
GS <- subset(l, Morphology!="aMean")
GS <- droplevels(GS)
boxplot(NormThickness~group*Morphology, data=GS,col=(c(blue1, red1)))
boxplot(Diff~group,data=l, col=(c(blue1,red1)))


l <- read.xlsx(file="OxfordCafK.xlsx", sheetName= "Curvature")
m <- glm(group ~  WhiteCurvGyral + Hemi  + SurfaceArea,  data=l, family = "binomial")
summary(m)
Controls <- subset(l, group=="control")
l$WhiteGyralNormCurv <- (l$WhiteCurvGyral - mean(Controls$WhiteCurvGyral))/sd(Controls$WhiteCurvGyral)
l$WhiteSulcalNormCurv <- (l$WhiteCurvSulcal - mean(Controls$WhiteCurvSulcal))/sd(Controls$WhiteCurvSulcal)
l$PialGyralNormCurv <- (l$PialCurvGyral - mean(Controls$PialCurvGyral))/sd(Controls$PialCurvGyral)
l$PialSulcalNormCurv <- (l$PialCurvSulcal - mean(Controls$PialCurvSulcal))/sd(Controls$PialCurvSulcal)
l$GyralSurfDiff <- l$WhiteCurvGyral - l$PialCurvGyral
l$SulcalSurfDiff <- l$WhiteCurvSulcal - l$PialCurvSulcal
l$PialSurfDiff <- l$PialCurvGyral - l$PialCurvSulcal
boxplot(GyralSurfDiff ~ group, data=l)
boxplot(SulcalSurfDiff ~ group, data=l)
boxplot(PialSurfDiff ~ group, data=l,col=(c(blue1,red1)))
l <- read.xlsx(file="OxfordCafK.xlsx", sheetName= "Boxplot")
red1   <- rgb(255/255, 191/255, 127/255)
blue1   <- rgb(195/255, 250/255, 130/255)
red4   <- rgb(255/255, 127/255, 0/255)
blue4   <- rgb(195/255, 229/255, 126/255)

boxplot(Normalised~group*Morph*Surface,data=l,col=(c(blue1,red1,blue1,red1,blue4, red4, blue4,red4)), at=c(1,2,3,4, 6,7,8,9), xlim=c(0.5,9.5), las=2)
Pat <- subset(l,  group=="patient"& Surface =="Pial")
m <- lm(Normalised ~ Morph, data=Pat)
summary(m)
l <- read.xlsx(file="GyralSulcalData.xlsx", sheetName= "GlobalCurvature")
%TO SHOW LISA
m <- glm(group ~ Diff + Hemi  + GSRatio + SurfaceArea,  data=l, family = "binomial")
summary(m)
ggplot(data=l,aes(x=MeanThickness, y=NormDiff, linetype=Hemi, colour=group))+geom_smooth(metho="lm")+geom_point()
