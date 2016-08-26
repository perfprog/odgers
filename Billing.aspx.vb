
Partial Class PPI_Billing
    Inherits System.Web.UI.Page
    Dim sProjectRefNo As String, sRowColor As String


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            YY_Load()
        End If
    End Sub

    Sub YY_Load()
        Dim i1 As Integer, L1 As ListItem
        For i1 = 2010 To Today.Year
            L1 = New ListItem
            L1.Text = i1
            L1.Value = i1
            Me.YY.Items.Add(L1)
            If i1 = Today.Year Then L1.Selected = True
        Next

        For i1 = 0 To Me.MM.Items.Count - 1
            If Me.MM.Items(i1).Value = Today.Month Then
                Me.MM.Items(i1).Selected = True
                Exit For
            End If
        Next
    End Sub

    Protected Sub btnSubmit_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnSubmit.Click
        Dim sFolderName As String, aHoganCodes(0) As String, files() As String
        Dim a1() As String, sSql As String, dv1 As System.Data.DataView, iCount As Integer


        sFolderName = (ConfigurationManager.AppSettings("ReportsFolderName"))
        sFolderName = Server.MapPath(sFolderName)
        Trace.Warn((sFolderName))
        files = System.IO.Directory.GetFiles(sFolderName, "*.pdf")
        Trace.Warn(files.Length)

        Dim i1 As Integer, f1 As System.IO.FileInfo, sDate As Date, sHoganCode As String

        'Build array of Hogan Codes
        For i1 = 0 To files.Length - 1
            f1 = New System.IO.FileInfo(files(i1))
            sDate = f1.LastWriteTime
            If sDate.Month = Me.MM.SelectedValue And sDate.Year = Me.YY.SelectedValue Then
                If InStr(f1.Name, "-") > 0 Then
                    iCount = iCount + 1
                    a1 = Split(f1.Name, "-")
                    sSql = "UPDATE Billing SET RegenCount=RegenCount+1"
                    sSql = sSql & ", LastWriteTime_Latest='" & Convert.ToDateTime(f1.LastWriteTime) & "'"
                    sSql = sSql & " WHERE FileName='" & f1.Name & "'"
                    sSql = sSql & " and LastWriteTime_Latest<'" & Convert.ToDateTime(f1.LastWriteTime) & "'"
                    sSql = sSql & " if @@ROWCOUNT=0"
                    sSql = sSql & "Insert into Billing(FileName, HoganUserName, LastWriteTime_First, LastWriteTime_Latest, ReportTypeID) Select "
                    sSql = sSql & " '" & f1.Name & "'"
                    sSql = sSql & ", '" & a1(0) & "'"
                    sSql = sSql & ", '" & Convert.ToDateTime(f1.LastWriteTime) & "'"
                    sSql = sSql & ", '" & Convert.ToDateTime(f1.LastWriteTime) & "'"
                    sSql = sSql & ", '" & a1(1) & "'"
                    sSql = sSql & " where (select Top 1 FileName from Billing where FileName='" & f1.Name & "') is null"
                    Trace.Warn(sSql)
                    CF.Runquery(sSql)
                Else
                    Trace.Warn("Skipped " & f1.Name)
                End If
            End If
        Next

        tabOffice.DataBind()

    End Sub

    Protected Sub tabOffice_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabOffice.ItemDataBound
        'Trace.Warn("data bound")

        Dim dv1 As System.Data.DataView, sSql As String, g1 As GridView
        sSql = "Select * from qryBilling where OfficeID=" & e.Item.DataItem("OfficeID")
        sSql = sSql & " and MM=" & Me.MM.SelectedValue
        sSql = sSql & " and YY=" & Me.YY.SelectedValue
        sSql = sSql & " order by ProjectRefNo, HoganUserName"
        Trace.Warn(sSql)
        dv1 = CF.DataView_Get(sSql)
        g1 = e.Item.FindControl("tabData")
        g1.DataSource = dv1
        g1.DataBind()

        Dim L1 As Label
        L1 = e.Item.FindControl("ReportCount")
        L1.Text = dv1.Table.Rows.Count

        'Trace.Warn("Found " & Me.TotalCount.Text)
        Me.TotalCount.Text = Me.TotalCount.Text + dv1.Table.Rows.Count
        Me.totalrow.Visible = (Request.Cookies("OfficeID").Value = "999")
   
    End Sub

    Sub tabData_DataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs)
        Exit Sub

        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("ProjectRefNo") <> sProjectRefNo Then
                If sRowColor = "#EEEEFF" Then
                    sRowColor = "#FFFFFF"
                Else
                    sRowColor = "#EEEEFF"
                End If
                sProjectRefNo = e.Row.DataItem("ProjectRefNo")
            End If
            e.Row.BackColor = Drawing.ColorTranslator.FromHtml(sRowColor)
        End If
    End Sub


    Protected Sub btnGetData_Click(sender As Object, e As System.EventArgs) Handles btnGetData.Click
        Me.TotalCount.Text = 0
        Trace.Warn("Reset 1")
        tabOffice.DataBind()
    End Sub
End Class
