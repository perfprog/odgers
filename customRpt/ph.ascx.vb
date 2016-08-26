
Partial Class C2_ph
    Inherits System.Web.UI.UserControl

    Public Property pReportName() As String
        Get
            Return Me.ReportName.Text
        End Get

        Set(ByVal Value As String)
            Me.ReportName.Text = Value
        End Set
    End Property

    Public Property pCName() As String
        Get
            Return Me.CName.Text
        End Get

        Set(ByVal Value As String)
            Me.CName.Text = Value
        End Set
    End Property

    Public Property pLF_TM() As String
        Get
            Return Me.LF_TM.Text
        End Get

        Set(ByVal Value As String)
            Me.LF_TM.Text = Value
        End Set
    End Property
End Class
