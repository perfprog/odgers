
Partial Class test_files
    Inherits System.Web.UI.Page

    Protected Sub btnList_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnList.Click
        ReportLog.Files_Scan(Me.DirName.Text)
    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Import1.Files_Scan("c:\inetpub\wwwroot\odgers_live\hoganreports")
        'ReportLog.Files_Scan("c:\inetpub\wwwroot\odgers_live\hoganreports")
    End Sub
End Class
