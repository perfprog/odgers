
Partial Class C2_ph_band1
    Inherits System.Web.UI.UserControl


    Public Property pPageTitle() As String
        Get
            Return Me.PageTitle.Text
        End Get

        Set(ByVal Value As String)
            Me.PageTitle.Text = Value
        End Set
    End Property

    Public Property pColorName() As String
        Get
            Return Me.ColorName.Text
        End Get

        Set(ByVal Value As String)
            Me.ColorName.Text = Value
        End Set
    End Property

    'background-image: url(../images/Header-Cyan.jpg); 

    Protected Sub Page_PreRender(sender As Object, e As System.EventArgs) Handles Me.PreRender
        Me.td1.Style.Add("background-image", "url(../images/Header-" & Me.ColorName.Text & ".jpg);")
        If Me.ColorName.Text = "Cyan" Then
            Me.td1.Height = 90 'was 80
        Else
            Me.td1.Height = 81
            Me.td1.VAlign = "top"
            Me.td1.Style.Add("padding-top", "27px")
        End If
    End Sub
End Class
