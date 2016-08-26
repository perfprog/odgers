Imports Microsoft.VisualBasic
Imports System.Data
Imports PPIMessagingHelper.PPIMessaging
Imports PPIExceptionHelper

Public Class CF
    'Public Shared Sub LogIt(sKey As String, sData As String, eType As System.Diagnostics.EventLogEntryType)

    'End Sub

    Public Shared Function NullToString(ByVal obj) As String
        If obj.Equals(DBNull.Value) Then
            NullToString = ""
        Else
            NullToString = obj
        End If
    End Function

    Public Shared Function NullToZero(ByVal obj) As String
        If obj.Equals(DBNull.Value) Then
            NullToZero = 0
        Else
            NullToZero = obj
        End If
    End Function

    Public Shared Sub Runquery(ByVal s1 As String)
        Dim c1 As System.Data.SqlClient.SqlConnection, cmd1 As System.Data.SqlClient.SqlCommand

        Dim sConn As String
        sConn = ConfigurationManager.ConnectionStrings("cMain").ConnectionString
        'Response.Write(sConn & " " & s1 & "<br>")
        c1 = New System.Data.SqlClient.SqlConnection(sConn)
        cmd1 = New System.Data.SqlClient.SqlCommand(s1, c1)


        Try
            c1.Open()
            cmd1.ExecuteNonQuery()
        Catch e As System.Data.SqlClient.SqlException
            's1 = s1 & " Errors: " & e.ToString
            Dim sExResult As String = PPIExceptionTools.HandleException(e, PPIEventType.NonFatalError)
            'CF.Email_Send("odgers@perfprog.com", "", "", "odgers Error", s1)
        Catch e As System.Exception
            's1 = s1 & " Errors: " & e.ToString
            Dim sExResult As String = PPIExceptionTools.HandleException(e, PPIEventType.NonFatalError)
            'CF.Email_Send("odgers@perfprog.com", "", "", "odgers Error", s1)
        Finally
            CF.Email_Send("odgers@perfprog.com", "", "", "odgers Update", s1)
            c1.Close()
        End Try
    End Sub

    'Cliff: Added overload if no msg type is to be specified
    Public Shared Function Email_Send(ByVal sFrom As String, ByVal sTo As String, ByVal sCC As String, ByVal sSubject As String, ByVal sBody As String) As String
        Return (Email_Send(sFrom, sTo, sCC, sSubject, sBody, PPIMessageType.Other))

    End Function

    Public Shared Function Email_Send(ByVal sFrom As String, ByVal sRecipient As String, ByVal sCC As String, ByVal sSubject As String, ByVal sBody As String, eMsgType As PPIMessageType) As String
        Dim sBCC As String = ConfigurationManager.AppSettings("bcc")
        Dim sSendResult As String = String.Empty

        Try
            sSendResult = PPIMessagingTools.SendEmail(sFrom, sRecipient, sCC, sBCC, sSubject, sBody, eMsgType)
        Catch ex As Exception
            sSendResult = ex.Message
            Dim sExResult As String = PPIExceptionTools.HandleException(ex, PPIEventType.NonFatalError)
        Finally

        End Try

        Return (sSendResult)

        'Dim objMail

        'objMail = System.Web.HttpContext.Current.Server.CreateObject("CDO.Message")
        'objMail.From = from
        'objMail.To = recepient
        'objMail.Bcc = ConfigurationManager.AppSettings("bcc")
        'objMail.cc = cc
        'objMail.Subject = subject
        'objMail.HTMLBody = body
        'objMail.Configuration.Fields.Item _
        '    ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
        ''Name or IP of remote SMTP server
        'objMail.Configuration.Fields.Item _
        '    ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "localhost"
        ''Server port
        'objMail.Configuration.Fields.Item _
        '    ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
        'objMail.Configuration.Fields.Update()
        'On Error Resume Next
        'objMail.Send()
        'objMail = Nothing
    End Function

    Public Shared Function DataView_Get(ByVal sSql As String) As System.Data.DataView
        Dim c1 As System.Data.SqlClient.SqlConnection, cmd1 As System.Data.SqlClient.SqlCommand
        Dim da As New System.Data.SqlClient.SqlDataAdapter
        Dim ds As New System.Data.DataSet

        c1 = New System.Data.SqlClient.SqlConnection(ConfigurationManager.ConnectionStrings("cMain").ConnectionString)
        cmd1 = New System.Data.SqlClient.SqlCommand(sSql, c1)
        da.SelectCommand = cmd1
        da.Fill(ds, "tempTable")
        DataView_Get = New System.Data.DataView(ds.Tables("tempTable"))

        c1.Close()
    End Function

    Public Shared Sub RunParamQuery(ByVal s1 As String, ByVal aNames() As String, ByVal aValues() As String)
        Dim c1 As SqlClient.SqlConnection, cmd1 As SqlClient.SqlCommand
        Dim sConn As String, i1 As Int16

        sConn = ConfigurationManager.ConnectionStrings("cMain").ConnectionString
        'Response.Write(sConn & " " & s1 & "<br>")
        c1 = New SqlClient.SqlConnection(sConn)
        cmd1 = New SqlClient.SqlCommand(s1, c1)


        If aValues.Length > 0 Then
            For i1 = 0 To aValues.Length - 1
                cmd1.Parameters.Add(New System.Data.SqlClient.SqlParameter(aNames(i1), aValues(i1)))
            Next
        End If
        c1.Open()
        cmd1.CommandType = Data.CommandType.StoredProcedure
        cmd1.ExecuteNonQuery()
        c1.Close()
    End Sub

    Public Shared Sub Cookies_Reset()
        Dim i1 As Integer
        For i1 = 0 To System.Web.HttpContext.Current.Request.Cookies.Count - 1
            System.Web.HttpContext.Current.Response.Cookies(System.Web.HttpContext.Current.Request.Cookies(i1).Name).Expires = Today.AddDays(-1)
        Next

        System.Web.HttpContext.Current.Trace.Warn("Cookies cleared")
    End Sub

    Public Shared Function LandingPage() As String
        If System.Web.HttpContext.Current.Request.Cookies("LandingPage") Is Nothing Then
            LandingPage = "default.aspx"
        Else
            LandingPage = System.Web.HttpContext.Current.Request.Cookies("LandingPage").Value
        End If
    End Function

    Public Shared Function FileName_Get(ByVal sFullName As String) As String
        Dim iPos As Integer
        iPos = InStrRev(sFullName, "\")
        FileName_Get = Mid(sFullName, iPos + 1)

    End Function

    Public Shared Function fsHtml(s1 As String) As String
        fsHtml = Replace(s1, vbCrLf, "<br>")

    End Function


    Public Shared Function Email_SendAttachment(ByVal sFrom As String, ByVal sTo As String, ByVal sCC As String, ByVal sSubject As String, ByVal sBody As String, Optional sAttachmentName As String = "") As String
        Dim sBCC As String = ConfigurationManager.AppSettings("bcc")
        Dim sSendResult As String = String.Empty
        Dim objFrom As PPIMailAddress = New PPIMailAddress()

        objFrom.EmailAddress = sFrom

        Try
            sSendResult = PPIMessagingTools.SendEmail(objFrom, sTo, sCC, sBCC, sSubject, sBody, sAttachmentName)
        Catch ex As Exception
            sSendResult = ex.Message
            Dim sExResult As String = PPIExceptionTools.HandleException(ex, PPIEventType.NonFatalError)
        Finally

        End Try

        Return (sSendResult)


        'Dim MailFrom As New System.Net.Mail.MailAddress(sFromAddress)
        'Dim MailObj As New System.Net.Mail.MailMessage

        'Dim addr() As String, i1 As Integer

        'addr = Split(sTo, ";")
        'For i1 = 0 To UBound(addr)
        '    MailObj.To.Add(addr(i1))
        'Next

        'MailObj.From = MailFrom

        'MailObj.Bcc.Add(ConfigurationManager.AppSettings("bcc"))

        'If sCC <> "" Then
        '    MailObj.CC.Add(sCC)
        'End If

        'MailObj.Subject = sSubject
        'MailObj.SubjectEncoding = System.Text.Encoding.UTF8

        'MailObj.Body = sBody
        'MailObj.IsBodyHtml = True
        'MailObj.BodyEncoding = System.Text.Encoding.UTF8


        ''Attachment
        'If sAttachmentName <> "" Then
        '    MailObj.Attachments.Add(New System.Net.Mail.Attachment(sAttachmentName))
        'End If

        'Dim smtp = New System.Net.Mail.SmtpClient("localhost")
        'smtp.Send(MailObj)

    End Function
End Class
