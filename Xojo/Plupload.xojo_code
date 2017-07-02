#tag WebPage
Begin WebDialog Plupload
   Compatibility   =   ""
   Cursor          =   0
   Enabled         =   True
   Height          =   300
   HelpTag         =   ""
   HorizontalCenter=   0
   Index           =   0
   Left            =   0
   LockBottom      =   False
   LockHorizontal  =   False
   LockLeft        =   False
   LockRight       =   False
   LockTop         =   False
   LockVertical    =   False
   MinHeight       =   0
   MinWidth        =   0
   Resizable       =   True
   Style           =   "None"
   TabOrder        =   0
   Title           =   "Plupload"
   Top             =   0
   Type            =   1
   VerticalCenter  =   0
   Visible         =   True
   Width           =   600
   ZIndex          =   1
   _DeclareLineRendered=   False
   _HorizontalPercent=   0.0
   _IsEmbedded     =   False
   _Locked         =   False
   _NeedsRendering =   True
   _OfficialControl=   False
   _OpenEventFired =   False
   _ShownEventFired=   False
   _VerticalPercent=   0.0
End
#tag EndWebPage

#tag WindowCode
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer, Details As REALbasic.MouseEvent)
		  // Determine if the user clicked below the dialog attempting to close it.
		  If (Y > me.Height) Then
		    DialogClosed() // Raise 'DialogClosed' event.
		    me.Close() // Close dialog.
		  End If
		  
		  Dim _left As Integer = ((Session.CurrentPage.Width / 2) - (me.Width / 2))
		  Dim _right As Integer = ((Session.CurrentPage.Width / 2) + (me.Width / 2))
		  
		  // Determine if the user clicked to the left or right of dialog.
		  If (X < _left) Then
		    DialogClosed() // Raise 'DialogClosed' event.
		    me.Close() // Close dialog.
		  End If
		  
		  If (X > _right) Then
		    DialogClosed() // Raise 'DialogClosed' event.
		    me.Close() // Close dialog.
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub Shown()
		  // Determine if we want to close the dialog when the upload is complete
		  If (UploadComplete_CloseDialog = True) Then
		    AddHandler Session.HashTagChanged, AddressOf hSession_HashTagChanged
		  End If
		  
		  // Initialize uploader
		  ExecuteJavaScript(mConstructJavascript())
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub hSession_HashTagChanged(sender As WebSession)
		  // Determine if the upload completed
		  If (Session.HashTag = "upload_complete") Then
		    // Remove handler for 'Session.HashTagChanged'
		    RemoveHandler Session.HashTagChanged, AddressOf hSession_HashTagChanged
		    // Raise 'DialogClosed' event
		    DialogClosed()
		    // Close Dialog
		    me.Close()
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function mConstructJavascript() As String
		  Dim _js() As String
		  
		  _js.Append("$(""#")
		  _js.Append(me.ControlID)
		  _js.Append("_body")
		  _js.Append(""").plupload({")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// General settings")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("runtimes : 'html5,flash,silverlight,html4',")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("url : '")
		  _js.Append(URL)
		  _js.Append("upload.php?directory=")
		  _js.Append(EncodeURLComponent(Upload_Directory))
		  _js.Append("',")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// User can upload no more then 20 files in one go (sets multiple_queues to false)")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("max_file_count: ")
		  _js.Append(Str(Upload_MaxCount) + ",")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("chunk_size: '1mb',")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Resize images on clientside if we can")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("resize : {")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("width : 200,")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("height : 200, ")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("quality : 90,")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("crop: true // crop to exact dimensions")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("},")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("filters : {")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Maximum file size")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("max_file_size : '")
		  _js.Append(Str(Upload_MaxFileSize_MB) + "mb',")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Specify what files to browse for")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("mime_types: [")
		  _js.Append(EndOfLine.Windows)
		  If (Allow_Images = True) Then
		    _js.Append("{title : ""Image files"", extensions : ""jpg,jpeg,gif,png""},")
		    _js.Append(EndOfLine.Windows)
		  End If
		  If (Allow_PDF = True) Then
		    _js.Append("{title : ""PDF files"", extensions : ""pdf""},")
		    _js.Append(EndOfLine.Windows)
		  End If
		  If (Allow_Zip = True) Then
		    _js.Append("{title : ""Zip files"", extensions : ""zip""},")
		    _js.Append(EndOfLine.Windows)
		  End If
		  If (Allow_Anything = True) Then
		    _js.Append("{title : ""Anything"", extensions : ""*""}")
		    _js.Append(EndOfLine.Windows)
		  End If
		  _js.Append("]")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("},")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Rename files by clicking on their titles")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("rename: true,")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Sort files")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("sortable: true,")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Enable ability to drag'n'drop files onto the widget (currently only HTML5 supports that)")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("dragdrop: true,")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Views to activate")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("views: {")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("list: true,")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("thumbs: true, // Show thumbs")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("active: 'thumbs'")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("},")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Flash settings")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("flash_swf_url : '")
		  _js.Append(URL)
		  _js.Append("js/Moxie.swf',")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("// Silverlight settings")
		  _js.Append(EndOfLine.Windows)
		  _js.Append("silverlight_xap_url : '")
		  _js.Append(URL)
		  _js.Append("js/Moxie.xap'")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("});")
		  _js.Append(EndOfLine.Windows)
		  
		  _js.Append(EndOfLine.Windows)
		  _js.Append("$('#")
		  _js.Append(me.ControlID)
		  _js.Append("_body').on('complete', function() {")
		  _js.Append(EndOfLine.Windows)
		  If (UploadComplete_ShowMessage = True) Then
		    _js.Append("alert(""")
		    _js.Append(UploadComplete_MessageText)
		    _js.Append(""");")
		    _js.Append(EndOfLine.Windows)
		  End If
		  If (UploadComplete_CloseDialog = True) Then
		    _js.Append("location.hash = 'upload_complete';")
		    _js.Append(EndOfLine.Windows)
		  End If
		  _js.Append("});")
		  _js.Append(EndOfLine.Windows)
		  
		  Return Join(_js, "")
		End Function
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event DialogClosed()
	#tag EndHook


	#tag Property, Flags = &h0
		Allow_Anything As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		Allow_Images As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Allow_PDF As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Allow_Zip As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Enable_DragDrop As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Enable_Rename As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Enable_Sort As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		UploadComplete_CloseDialog As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		UploadComplete_MessageText As String = "Your files were successfully uploaded."
	#tag EndProperty

	#tag Property, Flags = &h0
		UploadComplete_ShowMessage As Boolean = True
	#tag EndProperty

	#tag Property, Flags = &h0
		Upload_Directory As String = "uploads/"
	#tag EndProperty

	#tag Property, Flags = &h0
		Upload_MaxCount As Integer = 20
	#tag EndProperty

	#tag Property, Flags = &h0
		Upload_MaxFileSize_MB As Integer = 1000
	#tag EndProperty

	#tag Property, Flags = &h0
		URL As String
	#tag EndProperty


#tag EndWindowCode

#tag ViewBehavior
	#tag ViewProperty
		Name="Allow_Anything"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Allow_Images"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Allow_PDF"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Allow_Zip"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Cursor"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Automatic"
			"1 - Standard Pointer"
			"2 - Finger Pointer"
			"3 - IBeam"
			"4 - Wait"
			"5 - Help"
			"6 - Arrow All Directions"
			"7 - Arrow North"
			"8 - Arrow South"
			"9 - Arrow East"
			"10 - Arrow West"
			"11 - Arrow Northeast"
			"12 - Arrow Northwest"
			"13 - Arrow Southeast"
			"14 - Arrow Southwest"
			"15 - Splitter East West"
			"16 - Splitter North South"
			"17 - Progress"
			"18 - No Drop"
			"19 - Not Allowed"
			"20 - Vertical IBeam"
			"21 - Crosshair"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enabled"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enable_DragDrop"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enable_Rename"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Enable_Sort"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HelpTag"
		Visible=true
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HorizontalCenter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Index"
		Group="ID"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Left"
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockBottom"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockHorizontal"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockLeft"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockRight"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockTop"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LockVertical"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Minimum Size"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Minimum Size"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizable"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="TabOrder"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Behavior"
		InitialValue="Untitled"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Top"
		Group="Position"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Behavior"
		InitialValue="1"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"1 - Sheet"
			"2 - Palette"
			"3 - Modal"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="UploadComplete_CloseDialog"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UploadComplete_MessageText"
		Group="Behavior"
		InitialValue="Your files were successfully uploaded."
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="UploadComplete_ShowMessage"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Upload_Directory"
		Group="Behavior"
		InitialValue="uploads/"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Upload_MaxCount"
		Group="Behavior"
		InitialValue="20"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Upload_MaxFileSize_MB"
		Group="Behavior"
		InitialValue="1000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="URL"
		Group="Behavior"
		Type="String"
		EditorType="MultiLineEditor"
	#tag EndViewProperty
	#tag ViewProperty
		Name="VerticalCenter"
		Group="Behavior"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Behavior"
		InitialValue="300"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ZIndex"
		Group="Behavior"
		InitialValue="1"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_DeclareLineRendered"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_HorizontalPercent"
		Group="Behavior"
		Type="Double"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_IsEmbedded"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_Locked"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_NeedsRendering"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OfficialControl"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_OpenEventFired"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_ShownEventFired"
		Group="Behavior"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="_VerticalPercent"
		Group="Behavior"
		Type="Double"
	#tag EndViewProperty
#tag EndViewBehavior
