
Partial Class PPI_Billing
    Inherits System.Web.UI.Page
    Dim sProjectRefNo As String, sRowColor As String

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            YY_Load()
        End If
        Billing_Process()
    End Sub

    Sub YY_Load()
        Dim i1 As Integer, L1 As ListItem
        For i1 = 2010 To Today.Year
            L1 = New ListItem
            L1.Text = i1
            L1.Value = i1
            Me.YY.Items.Add(L1)
        Next
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Billing_Process()

    End Sub

    Sub Billing_Process_Orig()
        Dim sFolderName As String, aHoganCodes(0) As String, files() As String
        Dim a1() As String, sSql As String, dv1 As System.Data.DataView


        sFolderName = (ConfigurationManager.AppSettings("ReportsFolderName"))
        sFolderName = Server.MapPath("../" & sFolderName)
        'Trace.Warn((sFolderName))
        files = System.IO.Directory.GetFiles(sFolderName, "*.pdf")
        Dim i1 As Integer, f1 As System.IO.FileInfo, sDate As Date, sHoganCode As String

        'Prep Billing table
        sSql = "Delete from Billing where DateEntered<'" & Today.AddDays(-1) & "'"
        CF.Runquery(sSql)

        sSql = "Select Top 1 ID from Billing order by ID Desc"
        dv1 = CF.DataView_Get(sSql)
        If dv1.Table.Rows.Count = 0 Then
            Me.myID.Text = 1
        Else
            Me.myID.Text = dv1.Table.Rows(0)(0) + 1
        End If
        'Build array of Hogan Codes
        For i1 = 0 To files.Length - 1
            f1 = New System.IO.FileInfo(files(i1))
            sDate = f1.LastWriteTime
            If sDate.Month = Me.MM.SelectedValue And sDate.Year = Me.YY.SelectedValue Then
                'Add the HoganUserName from the file name to the list of codes
                If InStr(f1.Name, "-") > 0 Then
                    a1 = Split(f1.Name, "-")
                    sSql = "Insert into Billing(ID, FileName, HoganUserName, LastWriteTime, ReportTypeID) Select " & Me.myID.Text
                    sSql = sSql & ", '" & f1.Name & "'"
                    sSql = sSql & ", '" & a1(0) & "'"
                    sSql = sSql & ", '" & Convert.ToDateTime(f1.LastWriteTime).ToShortDateString & "'"
                    sSql = sSql & ", '" & a1(1) & "'"
                    Trace.Warn(sSql)
                    CF.Runquery(sSql)

                End If
            End If
        Next
    End Sub

    Sub Billing_Process()
        Dim sFolderName As String, aHoganCodes(0) As String, files() As String
        Dim a1() As String, sSql As String, dv1 As System.Data.DataView


        sFolderName = (ConfigurationManager.AppSettings("ReportsFolderName"))
        sFolderName = Server.MapPath("../" & sFolderName)
        'Trace.Warn((sFolderName))
        files = System.IO.Directory.GetFiles(sFolderName, "*.pdf")
        Dim i1 As Integer, f1 As System.IO.FileInfo, sDate As Date, sHoganCode As String

        'Prep Billing table
        sSql = "Delete from Billing"
        CF.Runquery(sSql)

        Me.myID.Text = 1

        'Build array of Hogan Codes
        For i1 = 0 To files.Length - 1
            f1 = New System.IO.FileInfo(files(i1))
            sDate = f1.LastWriteTime

            'Add the HoganUserName from the file name to the list of codes
            If InStr(f1.Name, "-") > 0 Then
                Trace.Warn(f1.Name)
                a1 = Split(f1.Name, "-")
                sSql = "Insert into Billing(ID, FileName, HoganUserName, LastWriteTime, ReportTypeID) Select " & Me.myID.Text
                sSql = sSql & ", '" & f1.Name & "'"
                sSql = sSql & ", '" & a1(0) & "'"
                sSql = sSql & ", '" & Convert.ToDateTime(f1.LastWriteTime).ToShortDateString & "'"
                sSql = sSql & ", '" & a1(1) & "'"
                Trace.Warn(sSql)
                CF.Runquery(sSql)

            End If
        Next
        Me.tabData.DataBind()
    End Sub


    Sub tabData_DataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("ReportTypeName") <> sProjectRefNo Then
                If sRowColor = "#EEEEFF" Then
                    sRowColor = "#FFFFFF"
                Else
                    sRowColor = "#EEEEFF"
                End If
                sProjectRefNo = e.Row.DataItem("ReportTypeName")
            End If
            e.Row.BackColor = Drawing.ColorTranslator.FromHtml(sRowColor)
        End If
    End Sub
End Class
