
Partial Class MessagingTest
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs) Handles Me.Load
        Dim sFrom As String = "surverys@performanceprograms.com"
        Dim sTo As String = "clifford@badalon.com"
        Dim sBody As String = "Test message from Cliff.  This is the body of the message."

        Dim sResult As String = CF.Email_Send(sFrom, sTo, "", "Test message from Cliff2", sBody) ', Server.MapPath("newserver.txt.txt"))     'test with an attachment
        'Dim sResult As String = CF.Email_SendAttachment(sFrom, sTo, "", "Test message from Cliff", sBody, Server.MapPath("newserver.txt.txt"))     'test with an attachment

        Response.Write(String.Format("<br/>Result: {0}", sResult))
    End Sub
End Class
