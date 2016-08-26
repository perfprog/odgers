
Partial Class C2_LFChart
    Inherits System.Web.UI.UserControl

    Const cMaxWidth As Integer = 400 '322

    Public Property pDeveloping() As String
        Get
            Return Me.chart_developing.Text
        End Get

        Set(ByVal Value As String)
            Me.chart_developing.Text = Value
        End Set
    End Property

    Public Property pProficient() As String
        Get
            Return Me.chart_proficient.Text
        End Get

        Set(ByVal Value As String)
            Me.chart_proficient.Text = Value
        End Set
    End Property

    Public Property pStrong() As String
        Get
            Return Me.chart_strong.Text
        End Get

        Set(ByVal Value As String)
            Me.chart_strong.Text = Value
        End Set
    End Property
    Public Property pOutstanding() As String
        Get
            Return Me.chart_outstanding.Text
        End Get

        Set(ByVal Value As String)
            Me.chart_outstanding.Text = Value
        End Set
    End Property

    Public Property pScale() As String
        Get
            Return Me.chart_scale.Text
        End Get

        Set(ByVal Value As String)
            Me.chart_scale.Text = Value
        End Set
    End Property

    Public Property pScore() As String
        Get
            Return Me.chart_score.Text
        End Get

        Set(ByVal Value As String)
            Me.chart_score.Text = Value
        End Set
    End Property

    Public Property pHeading() As String
        Get
            Return Me.chart_heading.Text
        End Get

        Set(ByVal Value As String)
            Me.chart_heading.Text = Value
        End Set
    End Property

    Protected Sub tabA_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabA.ItemDataBound
        Dim img1 As HtmlImage
        img1 = e.Item.FindControl("bar1")
        img1.Width = cMaxWidth * e.Item.DataItem("Score") / 100 - 1

        

    End Sub
End Class
