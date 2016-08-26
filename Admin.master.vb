
Partial Class Test
    Inherits System.Web.UI.MasterPage

    Sub Cookies_Reset()
        Dim i1 As Integer
        Trace.Warn(Request.Cookies.Count & " >> " & Response.Cookies.Count)
        For i1 = 0 To Request.Cookies.Count - 1
            Response.Cookies(Request.Cookies(i1).Name).Expires = DateTime.Now.AddDays(-1)
        Next
        Trace.Warn("Master Cookies cleared")
    End Sub

    Protected Sub btnLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogout.Click
        Cookies_Reset()
        Response.Redirect("default.aspx")
    End Sub

    Protected Sub Page_Init(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Init
        Dim sName As String
        Trace.Warn("Init Master")

        sName = UCase(Request.ServerVariables("SCRIPT_NAME"))

        If InStr(sName, "DEFAULT.ASPX") > 0 Then
            Cookies_Reset()
        Else
            Trace.Warn("Master Request.Cookies Count=" & Request.Cookies.Count)
            If Request.Cookies.Count = 0 Then
                Response.Redirect("Default.aspx?1")
            ElseIf Request.Cookies(0).Value = "" Then
                Response.Redirect("Default.aspx?2")
            Else
                Me.FullName.Text = Request.Cookies("FullName").Value
                Me.OfficeName.Text = Request.Cookies("OfficeName").Value
                Trace.Warn(Request.Cookies("OfficeID").Value)
                If Request.Cookies("OfficeID").Value < 999 Then
                    Me.Menu1.Visible = False
                End If

                'Disbale Logoutbutton
                If InStr(UCase(sName), UCase("Candidates.aspx")) > 0 Then
                    Me.btnLogout.Visible = False
                End If
            End If
        End If
    End Sub


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Cache.SetNoStore()
        
    End Sub

End Class

