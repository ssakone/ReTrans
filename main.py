# coding: utf-8
from PySide2.QtWidgets import *
from PySide2.QtCore import *
from PySide2.QtQml import *
from PySide2.QtGui import *

import os,re
from googletrans import Translator

class BackEnd(QObject):
	openData = []
	text= "cool"
	def __init__(self):
		QObject.__init__(self)
	@Slot()
	def texte(self):
		c = QFileDialog.getOpenFileNames(QWidget(),"File Name","")
		openData = c[0]
		for it in openData:
			name = it.split("/")[-1]
			if re.search(".vtt",name):
				self.root.addTask(name,it)
				self.openData.append(it)
				
	@Slot(str,str)
	def startTranslation(self,fromL,toL):
		tr = Translator()
		for n,it in enumerate(self.openData):
			data = open(it,"r").read()
			d = data.split("\n\n")
			ven = len(d)
			p = 0
			dd = ""
			for nn,ite in enumerate(d):
				p = (nn*100)/ven
				self.root.updatePer(n,p)
				if re.search("WEBVTT",ite):
					dd +=ite+"\n\n"
				elif re.search("-->",ite):
					dm = ite.split("\n")
					ddm = str(tr.translate(dm[1],dest=toL,src=fromL).text)#.replace("é","e").replace("è","e").replace("à","a").replace("ç","c")
					ddm = dm[0]+"\n"+ddm+"\n\n"
					dd+=ddm
				QApplication.processEvents()
			open(it+".fr.vtt","w").write(dd)
		self.root.openSucces()
	def open(self):
		print("opening")
a = QApplication([])

os.environ["QT_QUICK_CONTROLS_STYLE"] = "Material"

engine = QQmlApplicationEngine()
bc = BackEnd()	
engine.rootContext().setContextProperty("backend", bc)
engine.load(QUrl.fromLocalFile("main.qml"))
root = engine.rootObjects()[0]
bc.root = root


a.exec_()