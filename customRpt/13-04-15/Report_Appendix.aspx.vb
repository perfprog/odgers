Imports ChartDirector

Partial Class CustomRpt_Report_HPI
    Inherits System.Web.UI.Page

    Dim dvText As System.Data.DataView, sLanguageID As String
    Dim i1 As Integer, j1 As Integer, L1 As Label
    Dim data(7) As Double, labels(7) As String, dvScale As System.Data.DataView
    Dim dvCan As System.Data.DataView, bar1 As HtmlImage
    Const cMaxWidth As Integer = 372
    Dim sCandidateName As String, sScaleName As String, sLastName As String
    Dim dvCanText As System.Data.DataView, dvSubscales As System.Data.DataView
    Dim g1 As GridView, sScales As String, sPercentiles As String, sScaleInterpretations As String
    Dim sReportName As String
    Dim uc1 As C2_ph
    Dim sAppendix_Scores As String, sScaleType As String
    Dim gr As GridViewRow, tbl1 As Table, tc1 As TableCell
    Dim iRowOffset As Integer
    Dim sLow As String, sAvg As String, sHigh As String

    Const cBarColumn = 2

    Sub ReportText_Load(iLanguageID As Integer)
        
        dvText = CF.DataView_Get("Select KeyName, KeyValue from Reporttext where LanguageID=" & iLanguageID & " order by KeyName")

        'pMain
        For i1 = 0 To Me.pMain.Controls.Count - 1
            If Me.pMain.Controls(i1).ID <> "" Then
                For j1 = 0 To dvText.Table.Rows.Count - 1
                    If Me.pMain.Controls(i1).ID = dvText.Table.Rows(j1)("KeyName") Then
                        L1 = Me.pMain.Controls(i1)
                        L1.Text = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'chart
                    If dvText.Table.Rows(j1)("KeyName") = "chart_scales" Then
                        sScales = dvText.Table.Rows(j1)("KeyValue")
                    End If
                    If dvText.Table.Rows(j1)("KeyName") = "chart_percentiles" Then
                        sPercentiles = dvText.Table.Rows(j1)("KeyValue")
                    End If
                    If dvText.Table.Rows(j1)("KeyName") = "appendix_scores" Then
                        sAppendix_Scores = dvText.Table.Rows(j1)("KeyValue")
                    End If
                    If dvText.Table.Rows(j1)("KeyName") = "appendix_scaleinterpretations" Then
                        sScaleInterpretations = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "appendix_low" Then
                        sLow = dvText.Table.Rows(j1)("KeyValue")
                    End If
                    If dvText.Table.Rows(j1)("KeyName") = "appendix_average" Then
                        sAvg = dvText.Table.Rows(j1)("KeyValue")
                    End If
                    If dvText.Table.Rows(j1)("KeyName") = "appendix_high" Then
                        sHigh = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'ReportName
                    If dvText.Table.Rows(j1)("KeyName") = "appendix_reportname" Then
                        sReportName = dvText.Table.Rows(j1)("KeyValue")
                    End If
                Next
            End If
        Next

        'Appendix heading 2
        Me.hpi_appendix2.Text = Me.hpi_appendix.Text

    End Sub

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        'CF.Runquery("Exec results_Calc " & Request.QueryString("CandidateID"))

        dvCan = Me.rsCan.Select(DataSourceSelectArguments.Empty)
        sCandidateName = dvCan.Table.Rows(0)("FirstName") & " " & dvCan.Table.Rows(0)("LastName")
        sLastName = dvCan.Table.Rows(0)("LastName")

        Me.ph8.pCName = sCandidateName
        Me.ph9.pCName = sCandidateName
        Me.ph10.pCName = sCandidateName
        Me.ph8b.pCName = sCandidateName
        Me.ph10b.pCName = sCandidateName
        Me.ph10c.pCName = sCandidateName

        ReportText_Load(dvCan.Table.Rows(0)("LanguageID"))

        'ReportName
        Me.ph8.pReportName = sReportName
        Me.ph9.pReportName = sReportName
        Me.ph10.pReportName = sReportName
        Me.ph8b.pReportName = sReportName
        Me.ph10b.pReportName = sReportName
        Me.ph10c.pReportName = sReportName

        Me.phtitle8.pPageTitle = Me.hpi_appendix.Text
        Me.phtitle9.pPageTitle = Me.hpi_appendix2.Text
        Me.phtitle10.pPageTitle = sAppendix_Scores
        Me.phtitle8b.pPageTitle = Me.hpi_appendix.Text
        Me.phtitle10b.pPageTitle = sAppendix_Scores
        Me.phtitle10c.pPageTitle = sAppendix_Scores

        'Rest
        Me.tabChart.Attributes.Add("bordercolor", "#000000")
        Me.tab2.Attributes.Add("bordercolor", "Silver")

        
    End Sub

    Function fsDate(sDate As Date) As String
        Dim sCulture As String
        sCulture = "en-US"
        fsDate = sDate.ToString("M", New System.Globalization.CultureInfo(sCulture)) & ", " & sDate.Year

    End Function


    Protected Sub tabChart_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabChart.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
        ElseIf e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells(0).Text = sScales
            e.Row.Cells(cBarColumn).Text = sPercentiles
            e.Row.Cells(0).Style.Add("padding", "6px;")
            e.Row.Cells(cBarColumn).Style.Add("padding", "6px;")
            e.Row.Cells(cBarColumn - 1).Style.Add("padding", "6px;")
            Exit Sub
        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            L1 = e.Row.FindControl("txtLow")
            L1.Text = sLow

            L1 = e.Row.FindControl("txtAvg")
            L1.Text = sAvg

            L1 = e.Row.FindControl("txtHigh")
            L1.Text = sHigh
            Exit Sub
        Else
            Exit Sub
        End If

        'insert header image
        If e.Row.RowIndex = 0 Then
            Dim gr As GridViewRow, tbl1 As Table, tc1 As TableCell
            gr = New GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal)
            tbl1 = e.Row.Parent
            tbl1.Rows.AddAt(e.Row.RowIndex + 1, gr)
            tc1 = New TableCell
            'tc1.ColumnSpan = cBarColumn + 1
            'tc1.Text = "<b>" & "insert 0-100 scale here" & "</b>"
            'tc1.HorizontalAlign = HorizontalAlign.Center
            'tc1.CssClass = "selrow"
            gr.Cells.Add(tc1)
            tc1.ColumnSpan = cBarColumn
            tc1.Text = "&nbsp;"

            tc1 = New TableCell
            gr.Cells.Add(tc1)
            tc1.Style.Add("background-image", "url(../images/hpi_xscale-b.jpg)")
            'tc1.Height = 50
            Trace.Warn("Inserted ")

        End If

        e.Row.Cells(0).Style.Add("padding", "6px;")
        e.Row.Cells(cBarColumn - 1).Style.Add("padding", "10px;")
        e.Row.Cells(cBarColumn).Style.Add("background-image", "url(../images/hpi_lines_375a.jpg)")

        Dim div1 As HtmlGenericControl
        div1 = e.Row.Cells(cBarColumn).FindControl("div1")

        'insert blue/orange bar
        div1.Controls.Add(Bar_Get(e.Row.DataItem("Score"), e.Row.DataItem("IsLF")))

        'insert grey bar
        If e.Row.DataItem("GreyMin") > 0 Then
            div1.Controls.Add(GreyBar_get(e.Row.DataItem("GreyMin"), e.Row.DataItem("GreyMax")))
        End If

    End Sub

    Function Bar_Get(iScore As Single, IsLF As String) As HtmlTable
        Dim T1 As HtmlTable, tr1 As HtmlTableRow, tc1 As HtmlTableCell
        T1 = New HtmlTable
        T1.CellPadding = 0
        T1.CellSpacing = 0
        T1.Style("position") = "absolute"

        T1.Style("Left") = "0px"
        T1.Style("top") = "9px"
        T1.Style.Add("z-index", "2")

        T1.Width = cMaxWidth * (iScore) / 100

        If IsLF = "True" Then
            'T1.BgColor = "#FF0000"
            T1.Style.Add("background-image", "url(../images/Table-Bar-Orange.JPG)")
            'bar1.Src = "../images/Table-Bar-Orange.JPG"
        Else
            'bar1.Src = "../images/Table-Bar-Blue.JPG"
            'T1.BgColor = "#00FF00"
            T1.Style.Add("background-image", "url(../images/Table-Bar-Blue.JPG)")
        End If

        T1.Height = 10
        tr1 = New HtmlTableRow
        T1.Rows.Add(tr1)

        tc1 = New HtmlTableCell
        tr1.Cells.Add(tc1)
        tc1.Align = "right"
        tc1.InnerHtml = "<font ""size=1px;""> </font>"

        Bar_Get = T1


        

        
    End Function

    Function GreyBar_get(ByVal iMin As Single, ByVal iMax As Single) As HtmlTable
        Dim T1 As HtmlTable, tr1 As HtmlTableRow, tc1 As HtmlTableCell
        T1 = New HtmlTable
        T1.CellPadding = 0
        T1.CellSpacing = 0
        T1.Style("position") = "absolute"

        T1.Style("Left") = cMaxWidth * iMin / 100 & "px"
        T1.Style("Top") = "4px"
        T1.Style.Add("z-index", "1")

        T1.Width = cMaxWidth * (iMax - iMin) / 100
        'T1.Border = 1


        T1.BgColor = "#CCCCCC"
        T1.Height = 19
        tr1 = New HtmlTableRow
        T1.Rows.Add(tr1)

        tc1 = New HtmlTableCell
        tr1.Cells.Add(tc1)
        tc1.Align = "right"
        tc1.InnerHtml = "<font ""size=1px;""> </font>"

        GreyBar_get = T1
    End Function

    Protected Sub tab2_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.DataListItemEventArgs) Handles tab2.ItemDataBound
        If e.Item.ItemIndex = 0 Then
            dvSubscales = CF.DataView_Get("Select ScaleID, SubScaleName, SubScaleID, count1, Itemcount from qryCan_HPISubscales where CandidateID=" & Request.QueryString("CandidateID"))
        End If
        Dim dv2 As System.Data.DataView
        dv2 = New System.Data.DataView(dvSubscales.Table, "ScaleID=" & e.Item.DataItem("ScaleID"), "SubScaleID asc", System.Data.DataViewRowState.CurrentRows)

        For i1 = 0 To dv2.Count - 1
            Trace.Warn(dv2(i1)("SubScaleName"))
        Next
        g1 = e.Item.FindControl("tabSubscales")
        g1.DataSource = dv2
        g1.DataBind()
    End Sub



    Protected Sub tabHPI_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabHPI.RowDataBound
        tabHogan_Draw("HPI", e)
        Exit Sub

        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("ScaleType") <> "HPI" Then
                e.Row.Controls.Clear()

                Exit Sub
            End If
            If e.Row.DataItem("ScaleType") <> sScaleType Then
                sScaleType = e.Row.DataItem("ScaleType")

                gr = New GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal)
                tbl1 = e.Row.Parent
                tbl1.Rows.AddAt(e.Row.RowIndex + iRowOffset + 1, gr)
                tc1 = New TableCell
                tc1.ColumnSpan = Me.tabHPI.Columns.Count
                tc1.Text = "<b>" & e.Row.DataItem("ScaleName2") & "</b>"

                tc1.HorizontalAlign = HorizontalAlign.Center
                tc1.CssClass = "app_" & LCase(e.Row.DataItem("ScaleType"))

                Trace.Warn("Inserted " & Me.tabHPI.Rows.Count)
                gr.Cells.Add(tc1)

                iRowOffset = iRowOffset + 1
            End If
        End If

        If e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells(0).Text = sScales
            e.Row.Cells(2).Text = sScaleInterpretations
        End If

        'iRowOffset = iRowOffset + 1
    End Sub

    Sub tabHogan_Draw(sWhich As String, e As System.Web.UI.WebControls.GridViewRowEventArgs)
        If e.Row.RowType = DataControlRowType.DataRow Then
           
            If e.Row.DataItem("ScaleType") <> sScaleType Then
                sScaleType = e.Row.DataItem("ScaleType")

                gr = New GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal)
                tbl1 = e.Row.Parent


                tbl1.Rows.AddAt(e.Row.RowIndex + iRowOffset + 1, gr)
                tc1 = New TableCell
                tc1.ColumnSpan = 3 'Me.tabHPI.Columns.Count
                tc1.Text = "<b>" & e.Row.DataItem("ScaleName2") & "</b>"

                tc1.HorizontalAlign = HorizontalAlign.Center
                tc1.CssClass = "app_" & LCase(e.Row.DataItem("ScaleType"))

                Trace.Warn("Inserted ")
                gr.Cells.Add(tc1)

                'iRowOffset = iRowOffset + 1
            End If
        End If

        If e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells(0).Text = sScales
            e.Row.Cells(2).Text = sScaleInterpretations
            sScaleType = ""
        End If
    End Sub

    Protected Sub tabHDS_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabHDS.RowDataBound
        tabHogan_Draw("HDS", e)

    End Sub


    Protected Sub tabMVPI_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabMVPI.RowDataBound
        tabHogan_Draw("MVPI", e)
    End Sub
End Class
