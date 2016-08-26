
Partial Class Basecamp
    Inherits System.Web.UI.Page

    Dim sFolderName As String
    Dim sTargetFileName As String
    Dim f1 As System.IO.FileInfo

    Function fsUrl(sHoganUserName As String, sReportType As String) As String
        If sFolderName = "" Then
            sFolderName = (ConfigurationManager.AppSettings("ReportsFolderName"))
            sFolderName = Server.MapPath(sFolderName)
            Trace.Warn((sFolderName))
        End If

        sTargetFileName = sFolderName & "\" & sHoganUserName & "-" & sReportType & "-General.pdf"
        Trace.Warn(sTargetFileName)

        f1 = New System.IO.FileInfo(sTargetFileName)
        If f1.Exists Then
            fsUrl = ConfigurationManager.AppSettings("Approot")
            fsUrl = fsUrl & ConfigurationManager.AppSettings("ReportsFolderName")
            fsUrl = fsUrl & "/" & CF.FileName_Get(sTargetFileName)
            Trace.Warn(fsUrl)
        Else
            fsUrl = ""
        End If


    End Function

   

    Protected Sub tabCan_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabCan.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
        Else
            Exit Sub
        End If

        Dim hlx As HyperLink, i1 As Integer

        For i1 = 1 To 6
            hlx = e.Row.FindControl("hl" & i1)
            hlx.NavigateUrl = fsUrl(e.Row.DataItem("HoganUserName"), hlx.SkinID)
            If hlx.NavigateUrl <> "" Then
                hlx.Text = "Report"
                hlx.ToolTip = e.Row.DataItem("candidateName")
            End If

        Next

    End Sub
End Class
