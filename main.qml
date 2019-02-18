import QtQuick 2.11
import QtQuick.Controls 2.4
import QtQuick.Controls.Material 2.3
import "src/" as MT
MT.App {
	property color primaryBlack: Material.color(Material.Grey,Material.Shade600)
	property color primaryGrey: Material.color(Material.Grey,Material.Shade500)
	property string languageFrom : "fr"
	property string languageTo : "en"
	visible: true
	width: 800
	height: 600
	title: "Converter"
	function openSucces(){
		popup2.open()
	}
	function updatePer(id,per){
		var item = converList.get(id).percent = per
	}
	function addTask(name,path){
		var item = {"name":name,"path":path,"percent":0}
		converList.append(item)
	}
	ListModel {
		id:converList

	}
	Component {
		id: home
		MT.Page{

			backgroundColor: primaryGrey

			appBar.visible: true
			appBar.title:  "ReTrans"
			appBar.backgroundColor: primaryBlack
			appBar.elevation: 0
			appBar.actions: [
				MT.AppBarButton {
					icons: micon.iMore_vert
				}
			]
			Text{
				id:v
				text: bc.text
			}

			MT.TabView{
				x: drawer.visible? drawer.drawerWidth : 0
				width: drawer.visible? parent.width-drawer.drawerWidth : parent.width
				height: parent.height
				tabBackgroundColor: primaryBlack
				tabButtons: [
					TabButton {
						text:"INPUT"
					},
					TabButton {
						text:"OUTPUT"
					}
				]
				pageStacks: [
					Item {
						anchors.fill: parent
						ListView {
							anchors.fill: parent
							model: converList
							clip: true
							delegate: MT.ListItem {
								foregroundColor: 'white'
								title: name
								titleIcon: micon.iInsert_drive_file
								ProgressBar {
									from: 0
									to: 85
									Material.background: Material.Green
									anchors.bottom: parent.bottom
									width: parent.width
									value:percent
								}
							}
						}
					}
				]
			}
			MT.FloatActionButton {
				icons: micon.iTranslate
				backgroundColor: primaryBlack
				onClicked: {
					console.log('op')
					popup.open()
				}
			}

			MT.DesktopDrawer {
				id: drawer
				drawerWidth: 250
				visible: true
				height: parent.height
				elevation: 1
				Column {
					width: parent.width
					height: parent.height
					
					MT.ListView {
						width: parent.width
						height: parent.height
						colbody: [
							Item {
								id:logo
								scale:0.8
								width: parent.width
								height: 280
								Component.onCompleted: {
									logo.grabToImage(function(f){
										f.saveToFile("test.png")
										})
								}
								Rectangle {
									y:40
									width: parent.width-40
									height: 30
									radius: 10
									border.width: 4
									border.color: 'grey'
									anchors.centerIn: parent
								}
								Rectangle {
									y:40
									rotation: 135
									width: parent.width-40
									height: 30
									radius: 10
									border.width: 4
									border.color: 'grey'
									anchors.centerIn: parent
								}
								Rectangle {
									y:40
									rotation: 90
									width: parent.width-40
									height: 30
									radius: 10
									border.width: 4
									border.color: 'grey'
									anchors.centerIn: parent
								}
								Rectangle {
									y:40
									rotation:45
									width: parent.width-40
									height: 30
									radius: 10
									border.width: 4
									border.color: 'grey'
									anchors.centerIn: parent
								}
								Rectangle{
									anchors.centerIn: parent
									width: 80
									height: 80
									radius: 80
									border.width: 4
									border.color: 'grey'
									Text {
										text:"RT"
										font.pixelSize: 30
										anchors.centerIn: parent
										font.bold: true
										color:'grey'
									}
								}

								Rectangle {
									anchors.bottom: parent.bottom
									width: parent.width
									height: 1
									color: 'gray'
									opacity: 0.5
								}
							},
							MT.ListItem {
								foregroundColor: 'white'
								title: "Ouvrir"
								titleIcon: micon.iFolder
								opacity: 1
								objectName: "opener"
								onClicked: {
									backend.texte()
								}
							},
							MT.ListItem {
								foregroundColor: 'white'
								title: "History"
								titleIcon: micon.iHistory
								opacity: 1
							}
						]
					}
				}
			}
			
			Popup {
	          id: popup
	          x: parent.width/2-400/2
	          y: parent.height/2-300/2
	          width: 400
	          height: 300
	          modal: true
	          focus: true
	          closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent
	          Column {
	          	anchors.fill: parent
	          	Label {
	          		text: "Language Choice"
	          		font.pixelSize: 27
	          		font.weight: Font.Thin
	          	}
	          	Item {
	          		height: 7
	          		width: 1
	          	}
	          	Rectangle {
	          		width: parent.width-10
	          		anchors.horizontalCenter: parent.horizontalCenter
	          		color: 'grey'
	          		opacity: 0.7
	          		height: 1
	          	}
	          	Item {
	          		height: 20
	          		width: 1
	          	}
	          	Row {
	          		height: 50
	          		anchors.horizontalCenter: parent.horizontalCenter
	          		ComboBox {
	          			model: ["fr","en"]
	          			id:p1
	          		}
	          		Label {
	          			text: " <Language> "
	          			anchors.verticalCenter: parent.verticalCenter
	          		}
	          		ComboBox {
	          			id: p2
	          			model: ["fr","en"]
	          		}
	          	}
	          }
	          Pane {
	          	anchors.bottom: parent.bottom
	          	width: parent.width
	          	Material.elevation: 1
	          	height: 60
	          	Button {
	          		anchors.right: parent.right
	          		anchors.verticalCenter: parent.verticalCenter
	          		text: "Save"
	          		Material.foreground: Material.color(Material.Grey,Material.Shade50)
	          		Material.background: Material.Green
	          		onClicked: {
	          			languageFrom = p1.currentText
	          			languageTo = p2.currentText
	          			popup.close()
	          		}
	          	 }
	          }
	        }
			footer: MT.AppBar {
				backgroundColor: primaryBlack
				visible: true
				elevation: 0
				height: 50

				leading.icons: micon.iHelp
				actions: [
					Label{
						anchors.verticalCenter: parent.verticalCenter
						text:languageFrom+" ---> "+languageTo
						font.pixelSize: 20
						color: 'white'
					},
					MT.AppBarButton{
						icons: micon.iRefresh
					},
					Button {
						text: "Translate Subtitle "+micon.iTitle
						font.family: material_font.name
						Material.background: Material.Green
						anchors.verticalCenter: parent.verticalCenter
						onClicked: {
							backend.startTranslation(languageFrom,languageTo)
						}
					},
					Button {
						text: "Translate Voice "+micon.iMic
						font.family: material_font.name
						Material.background: Material.Green
						anchors.verticalCenter: parent.verticalCenter
					}
				]
			}
		}
		
	}

	MT.StackView {
		anchors.fill: parent
		initialItem: home
	}
	Popup {
	          id: popup2
	          x: parent.width/2-300/2
	          y: parent.height/2-300/2
	          width: 300
	          height: 300
	          modal: true
	          focus: true
	          closePolicy: Popup.CloseOnPressOutside
	          Column {
	          	height: 200
	          	width: parent.width
	          	anchors.centerIn: parent
	          	MT.AppBarButton {
	          		icons: micon.iDone
	          		enabled: false
	          		color: 'green'
	          		anchors.horizontalCenter: parent.horizontalCenter
	          	}
	          	Item {
	          		height: 20
	          		width: 1 
	          	}
	          	Label {
	          		text: "Translation terminated"
	          		font.pixelSize: 20
	          		anchors.horizontalCenter: parent.horizontalCenter
	          	}


	          }
	      }
}