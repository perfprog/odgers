Imports ChartDirector

Partial Class CustomRpt_Report_HPI2
    Inherits System.Web.UI.Page

    Dim dvText As System.Data.DataView
    Dim i1 As Integer, j1 As Integer, L1 As Label
    Dim data(7) As Double, labels(7) As String, dvScale As System.Data.DataView
    Dim dvCan As System.Data.DataView, bar1 As HtmlImage
    Const cMaxWidth As Integer = 409
    Dim sCandidateName As String, sScaleName As String, sLastName As String, sFirstName As String
    Dim sLeaderfitAnalysis As String, sRelatedCompetencies As String, sIndividualAnalysis As String
    Dim dvCanText As System.Data.DataView, dvSubscales As System.Data.DataView
    Dim g1 As GridView, sScales As String, sPercentiles As String
    Dim sLevelName As String, sHDS_high As String, sHDS_med As String
    Dim sMVPI_high As String, sMVPI_low As String, sMVPI_med As String
    Dim sReportName As String, shpi_strengths As String, shpi_gaps As String
    Dim shpi_valid As String, shpi_invalid As String
    Dim sNodata As String
    Dim uc1 As C2_ph
    Dim ShowMVPI As Boolean, ShowHDS As Boolean
    Dim smvpi_title As String, shds_title As String
    Dim shds_intro As String, smvpi_intro As String
    Dim shds_continued1 As String, shds_continued2 As String
    Dim iPageNo As Integer, bSuppressMed As Boolean
    Dim sCareerDev As String, sCareerDevIntro As String
    Dim slf_dimension As String, slf_hogancomps As String, slf_hpiscales As String
    Dim schart_developing As String, schart_proficient As String, schart_strong As String, schart_outstanding As String
    Dim schart_heading As String, schart_scale As String, schart_score As String
    Dim sLF_TM As String

    Dim IsBenchmark As Boolean
    Dim ShowGraph As Boolean


    Const cHDSCount = 4 ' max to be printed on first page, used with ItemIndex, so zero relative. 4==>5

    Sub ReportText_Load(iLanguageID As Integer)
        dvText = CF.DataView_Get("Select KeyName, KeyValue from Reporttext where LanguageID=" & iLanguageID & " order by KeyName")

        'pMain
        For i1 = 0 To Me.pMain.Controls.Count - 1
            If Me.pMain.Controls(i1).ID <> "" Then
                Trace.Warn(Me.pMain.Controls(i1).ID)
                For j1 = 0 To dvText.Table.Rows.Count - 1
                    If Me.pMain.Controls(i1).ID = dvText.Table.Rows(j1)("KeyName") Then
                        L1 = Me.pMain.Controls(i1)
                        L1.Text = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'he/she, him/her
                    If LCase(CF.NullToString(dvCan.Table.Rows(0)("Gender"))) = "male" Or LCase(CF.NullToString(dvCan.Table.Rows(0)("Gender"))) = "" Then
                        If dvText.Table.Rows(j1)("KeyName") = "male_he" Then Me.gender_he.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "male_him" Then Me.gender_him.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "male_he2" Then Me.gender_he2.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "male_his" Then Me.gender_his.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "male_his2" Then Me.gender_his2.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "male_mr" Then Me.gender_mr.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "male_himself" Then Me.gender_himself.Text = dvText.Table.Rows(j1)("KeyValue")
                    Else
                        If dvText.Table.Rows(j1)("KeyName") = "female_he" Then Me.gender_he.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "female_him" Then Me.gender_him.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "female_he2" Then Me.gender_he2.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "female_his" Then Me.gender_his.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "female_his2" Then Me.gender_his2.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "female_mr" Then Me.gender_mr.Text = dvText.Table.Rows(j1)("KeyValue")
                        If dvText.Table.Rows(j1)("KeyName") = "female_himself" Then Me.gender_himself.Text = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'CareerDev
                    If dvText.Table.Rows(j1)("KeyName") = "hpi_careerdev" Then
                        sCareerDev = dvText.Table.Rows(j1)("KeyValue")
                    End If
                    If dvText.Table.Rows(j1)("KeyName") = "careerdev_intro" Then
                        sCareerDevIntro = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'strengths and gaps
                    If dvText.Table.Rows(j1)("KeyName") = "hpi_strengths" Then
                        shpi_strengths = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "hpi_gaps" Then
                        shpi_gaps = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'MVPI
                    If dvText.Table.Rows(j1)("KeyName") = "mvpi_title" Then
                        smvpi_title = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "mvpi_intro" Then
                        smvpi_intro = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "hds_continued1" Then
                        shds_continued1 = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "hds_continued2" Then
                        shds_continued2 = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'HDS
                    If dvText.Table.Rows(j1)("KeyName") = "hds_title" Then
                        shds_title = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "hds_intro" Then
                        shds_intro = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'valid/invalid
                    If dvText.Table.Rows(j1)("KeyName") = "hpi_valid" Then
                        shpi_valid = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "hpi_invalid" Then
                        shpi_invalid = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'Leaderfit
                    If dvText.Table.Rows(j1)("KeyName") = "hpi_relatedcompetencies" Then
                        sRelatedCompetencies = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "hpi_individualanalysis" Then
                        sIndividualAnalysis = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "benchmark_leaderfitanalysissummary_notm" Then
                        Me.benchmark_leaderfitanalysissummary_notm.Text = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'HDS
                    If dvText.Table.Rows(j1)("KeyName") = "lf_tm" Then
                        sLF_TM = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'No data
                    If dvText.Table.Rows(j1)("KeyName") = "nodata" Then
                        sNodata = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    'Section
                    If dvText.Table.Rows(j1)("KeyName") = "toc_section" Then
                        Me.toc_section1.Text = dvText.Table.Rows(j1)("KeyValue")
                        Me.toc_section2a.Text = Me.toc_section1.Text
                    End If

                    'ReportName
                    If dvText.Table.Rows(j1)("KeyName") = "rptname_benchmark" Then
                        'If dvCan.Table.Rows(0)("AssgnTypeID") = 21 Or dvCan.Table.Rows(0)("AssgnTypeID") = 23 Or dvCan.Table.Rows(0)("AssgnTypeID") = 19 Or dvCan.Table.Rows(0)("AssgnTypeID") = 30 Then
                        If IsBenchmark Then
                            sReportName = dvText.Table.Rows(j1)("KeyValue")
                        End If
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "rptname_potential" Then
                        'If dvCan.Table.Rows(0)("AssgnTypeID") = 20 Or dvCan.Table.Rows(0)("AssgnTypeID") = 22 Or dvCan.Table.Rows(0)("AssgnTypeID") = 18 Then
                        If Not IsBenchmark Then
                            sReportName = dvText.Table.Rows(j1)("KeyValue")
                        End If
                    End If

                    'Assessment Methodology
                    If dvText.Table.Rows(j1)("KeyName") = "potential_methodologyintro" Then
                        'If dvCan.Table.Rows(0)("AssgnTypeID") = 20 Or dvCan.Table.Rows(0)("AssgnTypeID") = 22 Or dvCan.Table.Rows(0)("AssgnTypeID") = 18 Then
                        If Not IsBenchmark Then
                            Me.methodologyintro2.Text = dvText.Table.Rows(j1)("KeyValue")
                        End If
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "benchmark_methodologyintro" Then
                        'If dvCan.Table.Rows(0)("AssgnTypeID") = 21 Or dvCan.Table.Rows(0)("AssgnTypeID") = 23 Or dvCan.Table.Rows(0)("AssgnTypeID") = 19 Or dvCan.Table.Rows(0)("AssgnTypeID") = 30 Then
                        If IsBenchmark Then
                            Me.methodologyintro2.Text = dvText.Table.Rows(j1)("KeyValue")
                        End If
                    End If


                    'chart
                    If dvText.Table.Rows(j1)("KeyName") = "chart_scales" Then
                        sScales = dvText.Table.Rows(j1)("KeyValue")
                    End If
                    If dvText.Table.Rows(j1)("KeyName") = "chart_percentiles" Then
                        sPercentiles = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "lf_dimension" Then
                        slf_dimension = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "lf_hogancomps" Then
                        slf_hogancomps = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "lf_hpiscales" Then
                        slf_hpiscales = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "chart_developing" Then
                        schart_developing = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "chart_proficient" Then
                        schart_proficient = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "chart_strong" Then
                        schart_strong = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "chart_outstanding" Then
                        schart_outstanding = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "chart_scale" Then
                        schart_scale = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "chart_score" Then
                        schart_score = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "chart_heading" Then
                        schart_heading = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "lf_chartintro" Then
                        Me.lf_chartintro.Text = dvText.Table.Rows(j1)("KeyValue")
                    End If

                    If dvText.Table.Rows(j1)("KeyName") = "benchmark_leaderfitanalysissummary" Then
                        Me.benchmark_leaderfitanalysissummary.Text = dvText.Table.Rows(j1)("KeyValue")
                        'Me.benchmark_leaderfitanalysissummary2.Text = Me.benchmark_leaderfitanalysissummary.Text
                    End If
                Next
            End If
        Next
    End Sub


    Protected Sub tabMVPI1_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabMVPI1.ItemDataBound
        'If e.Item.ItemIndex = 0 Then
        '    If e.Item.DataItem("LevelName") = "high" Then
        '        bSuppressMed = True
        '    End If
        'End If

        'If bSuppressMed Then
        '    If e.Item.DataItem("LevelName") <> "high" Then
        '        e.Item.Controls.Clear()
        '        Exit Sub
        '    End If
        'End If


        'Overview
        L1 = e.Item.FindControl("Overview")
        If IsNumeric(Left(System.Guid.NewGuid().ToString(), 1)) Then
            i1 = 1
        Else
            i1 = 2
        End If

        L1.Text = Genderize(e.Item.DataItem("Overview" & i1))



    End Sub

    Sub AssgnType_Set(iAssgnTypeID As Integer)
        'Benchmark
        '21: HBC Benchmark English
        '23: HBC Benchmark French
        '19: Odgers Benchmark
        '30: Odgers Benchmark with Graph


        'Potential 
        '20: HBC Potential English
        '22: HBC Potential French
        '18: Odgers Potential
        '42: Odgers Potential with Graph

        'Free
        '43: Odgers Benchmark
        '44: Odgers Benchmark with Graph
        '45: Odgers Potential
        '46: Odgers Potential with Graph

        'This version of the report will NOT support HBC versions
        IsBenchmark = False
        ShowGraph = False

        If iAssgnTypeID = 19 Or iAssgnTypeID = 30 _
            Or iAssgnTypeID = 43 Or iAssgnTypeID = 44 Then
            IsBenchmark = True
            If iAssgnTypeID = 30 Or iAssgnTypeID = 44 Then
                ShowGraph = True
            End If

        ElseIf iAssgnTypeID = 18 Or iAssgnTypeID = 42 _
            Or iAssgnTypeID = 45 Or iAssgnTypeID = 46 Then
            IsBenchmark = False
            If iAssgnTypeID = 42 Or iAssgnTypeID = 46 Then
                ShowGraph = True
            End If
        Else
            'Should never come here - unknown assignment type
            'will be treated as Potential without Graph

        End If

    End Sub
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        CF.Runquery("Exec results_Calcv2 " & Request.QueryString("CandidateID"))

        dvCan = Me.rsCan.Select(DataSourceSelectArguments.Empty)
        'AssgnType_Set(dvCan.Table.Rows(0)("AssgnTypeID"))
        Dim a1 As New AssgnType(dvCan.Table.Rows(0)("AssgnTypeID"))
        ShowGraph = a1.ShowGraph
        IsBenchmark = a1.IsBenchmark


        sCandidateName = dvCan.Table.Rows(0)("FirstName") & " " & dvCan.Table.Rows(0)("LastName")
        sLastName = dvCan.Table.Rows(0)("LastName")
        sFirstName = dvCan.Table.Rows(0)("FirstName")

        'Cover image 'per 3/8/12 message from Kristen
        'If dvCan.Table.Rows(0)("AssgnTypeID") = 20 Or dvCan.Table.Rows(0)("AssgnTypeID") = 22 Or dvCan.Table.Rows(0)("AssgnTypeID") = 18 Then
        If Not IsBenchmark Then
            Me.CoverImage.Src = "../images/TitlePage-Header-Orange.jpg"
        End If

        'Bay Image
        'If dvCan.Table.Rows(0)("AssgnTypeID") = 20 Or dvCan.Table.Rows(0)("AssgnTypeID") = 21 _
        'Or dvCan.Table.Rows(0)("AssgnTypeID") = 22 Or dvCan.Table.Rows(0)("AssgnTypeID") = 23 Then
        'CIBC
        If dvCan.Table.Rows(0)("AssgnTypeID") = 21 Then
            'If dvCan.Table.Rows(0)("LanguageID") = 1 Then
            'Me.ClientImage.Src = "../images/myc_logo.jpg" 'was hbc
            'Me.ClientImage.Src = "../images/myc_logo.jpg" 'was myc
            Me.ClientImage.Src = "../images/cibc_logo.jpg" 'cibc
            'Else
            'Me.ClientImage.Src = "../images/myc_logo_fr.jpg" 'was hbc
            'End If
        Else
            Me.ClientImage.Src = "../images/whitespace.jpg"
        End If

        'Leaderfit Image
        If dvCan.Table.Rows(0)("LanguageID") = 2 Then
            Me.lf_image.Src = "../images/Infographic-FR.jpg"
        ElseIf dvCan.Table.Rows(0)("LanguageID") = 6 Then
            Me.lf_image.Src = "../images/Infographic-DE.jpg"
        ElseIf dvCan.Table.Rows(0)("LanguageID") = 8 Then
            Me.lf_image.Src = "../images/Infographic-ES.jpg"
        End If

        'Text
        ShowHDS = (InStr(dvCan.Table.Rows(0)("HoganSections"), "HDS") > 0)
        ShowMVPI = (InStr(dvCan.Table.Rows(0)("HoganSections"), "MVPI") > 0)

        Me.CName4.Text = sCandidateName
        Me.ClientName.Text = CF.NullToString(dvCan.Table.Rows(0)("ClientName"))

        'Suppress Assignment Name for HBC
        'If dvCan.Table.Rows(0)("AssgnTypeID") >= 20 And dvCan.Table.Rows(0)("AssgnTypeID") <= 23 Then
        'Me.AssgnName.Text = ""
        'Else
        Me.AssgnName.Text = CF.NullToString(dvCan.Table.Rows(0)("AssgnDesc"))
        'End If

        Me.Reportdate.Text = fsDate(dvCan.Table.Rows(0)("DateLFGenerated"), dvCan.Table.Rows(0)("LanguageID"))

        Me.ph1.pCName = sCandidateName
        Me.ph1a.pCName = sCandidateName
        Me.ph2.pCName = sCandidateName
        Me.ph3.pCName = sCandidateName
        Me.ph4.pCName = sCandidateName
        Me.ph5.pCName = sCandidateName
        Me.ph6.pCName = sCandidateName
        Me.ph7.pCName = sCandidateName
        Me.ph10.pCName = sCandidateName


        ReportText_Load(dvCan.Table.Rows(0)("LanguageID"))

        If CF.NullToZero(dvCan.Table.Rows(0)("Valid")) < 10 Then
            Me.hpi_note.Text = shpi_invalid
        Else
            Me.hpi_note.Text = shpi_valid
        End If

        'Me.benchmark_leaderfitanalysis2.Text = Me.benchmark_leaderfitanalysis.Text
        Me.mvpi_title2.Text = smvpi_title
        Me.hds_title2.Text = shds_title
        Me.hpi_careerdev.Text = sCareerDev
        Me.hpi_careerdev2.Text = Me.hpi_careerdev.Text
        Me.careerdev_intro.Text = sCareerDevIntro

        'ReportName
        Me.ReportName.Text = sReportName
        Me.ph1.pReportName = sReportName
        Me.ph1a.pReportName = sReportName
        Me.ph2.pReportName = sReportName
        Me.ph3.pReportName = sReportName
        Me.ph4.pReportName = sReportName
        Me.ph5.pReportName = sReportName
        Me.ph6.pReportName = sReportName
        Me.ph7.pReportName = sReportName
        Me.ph10.pReportName = sReportName

        'LF_TM
        Me.ph1.pLF_TM = sLF_TM
        Me.ph1a.pLF_TM = sLF_TM
        Me.ph2.pLF_TM = sLF_TM
        Me.ph3.pLF_TM = sLF_TM
        Me.ph4.pLF_TM = sLF_TM
        Me.ph5.pLF_TM = sLF_TM
        Me.ph6.pLF_TM = sLF_TM
        Me.ph7.pLF_TM = sLF_TM
        Me.ph10.pLF_TM = sLF_TM

        Me.phtitle1.pPageTitle = sReportName
        Me.phtitle2.pPageTitle = Me.hpi_overviewtitle.Text
        Me.phtitle3.pPageTitle = Me.hpi_strengthsgaps.Text
        Me.phtitle4.pPageTitle = Me.benchmark_leaderfitanalysis.Text
        Me.phtitle5.pPageTitle = shds_title
        Me.phtitle6.pPageTitle = shds_title
        Me.phtitle7.pPageTitle = smvpi_title
        Me.phtitle10.pPageTitle = Me.hpi_careerdev.Text

        Me.phtitle1a.pPageTitle = Me.benchmark_leaderfitanalysissummary.Text
        'Me.benchmark_leaderfitanalysissummary2.Text = Me.benchmark_leaderfitanalysissummary.Text
        Trace.Warn(">>>>??" & Me.benchmark_leaderfitanalysissummary.Text)


        'Rest
        tabGaps_Bind()
        Overview_Load()
        'Me.tabChart.Attributes.Add("bordercolor", "#000000")
        'Me.tab2.Attributes.Add("bordercolor", "Silver")

        'Sections to show/hide
        Me.hds_intro.Text = shds_intro
        Me.mvpi_intro.Text = smvpi_intro
        Me.hds_continued1.Text = shds_continued1
        Me.hds_continued2.Text = shds_continued2
        'Me.div_lfchart.Visible = True ' (dvCan.Table.Rows(0)("AssgnTypeID") = 30)
        Me.div_lfchart.Visible = ShowGraph
        If Me.div_lfchart.Visible Then
            Me.lfchart1.pDeveloping = schart_developing
            Me.lfchart1.pProficient = schart_proficient
            Me.lfchart1.pStrong = schart_strong
            Me.lfchart1.pOutstanding = schart_outstanding
            Me.lfchart1.pScale = schart_scale
            Me.lfchart1.pScore = schart_score
            Me.lfchart1.pHeading = schart_heading
        End If

        Me.pMVPI1.Visible = ShowMVPI

        Me.pHDS1.Visible = ShowHDS
        'Me.pHDS2.Visible = ShowHDS -- managed in HDS-ItemDatabound

        'TOC sections to show/hide
        Me.toc_mvpi.Visible = ShowMVPI
        Me.toc_hds.Visible = ShowHDS
        'Me.toc_leaderfit.Visible = True '(dvCan.Table.Rows(0)("AssgnTypeID") = 30)
        Me.toc_leaderfit.Visible = ShowGraph

        'If True Then 'dvCan.Table.Rows(0)("AssgnTypeID") = 30 Then 'with LeaderFit chart
        If ShowGraph Then
            iPageNo = 11
        Else
            iPageNo = 10
        End If


        If ShowHDS Then
            Me.pageno_hds.Text = iPageNo
            Dim dvHds As System.Data.DataView
            dvHds = Me.rsHDS.Select(DataSourceSelectArguments.Empty)
            If dvHds.Table.Rows.Count <= cHDSCount + 1 Then 'because zero relative for ItemIndex
                iPageNo = iPageNo + 1
            Else
                iPageNo = iPageNo + 2
            End If
        End If

        If ShowMVPI Then
            Me.pageno_mvpi.Text = iPageNo
            iPageNo = iPageNo + 1
        End If
        'Career Dev section - orig
        'If ShowHDS = False And ShowMVPI = False Then
        '    Me.pCareerDev.Visible = False
        '    Me.toc_careerdev.Visible = False
        '    Me.toc_section2.Visible = False
        'Else
        '    'default for pCareerDev and toc_Careerdev are true anyway
        '    Me.pageno_careerdev.Text = iPageNo
        'End If

        'new handling of Career Dev section 8/3/12
        ' show career dev section ony for HBC Benchmark
        'Commented out HBC code as part of IsBenchmark/ShowGraph changes 3/29/13
        'If dvCan.Table.Rows(0)("AssgnTypeID") >= 20 And dvCan.Table.Rows(0)("AssgnTypeID") <= 23 Then
        '    If ShowHDS = False And ShowMVPI = False Then
        '        Me.pCareerDev.Visible = False
        '        Me.toc_careerdev.Visible = False
        '        Me.toc_section2.Visible = False
        '    Else
        '        'default for pCareerDev and toc_Careerdev are true anyway
        '        Me.pageno_careerdev.Text = iPageNo
        '    End If
        'Else
        'non-hbc
        Me.pCareerDev.Visible = False
        Me.toc_careerdev.Visible = False
        If ShowHDS = False And ShowMVPI = False Then
            Me.toc_section2.Visible = False
        Else
            Me.toc_section2.Visible = True
        End If
        'End If
    End Sub

    Function fsDate(sDate As Date, iLanguageID As Integer) As String
        Dim sCulture As String
        If iLanguageID = 2 Then
            sCulture = "fr-FR"
        Else
            sCulture = "en-US"
        End If

        fsDate = sDate.ToString("M", New System.Globalization.CultureInfo(sCulture)) & ", " & sDate.Year

    End Function


    Sub Chart_Draw()
        'Load data and labels
        'dvScale = Me.rsScales.Select(DataSourceSelectArguments.Empty)
        For i1 = 0 To dvScale.Table.Rows.Count - 1
            labels(6 - i1) = dvScale.Table.Rows(i1)("ScaleName")
        Next

        'data(6) = dvCan.Table.Rows(0)("HPI_Adjustment")
        'data(5) = dvCan.Table.Rows(0)("HPI_Ambition")
        'data(4) = dvCan.Table.Rows(0)("HPI_Sociability")
        'data(3) = dvCan.Table.Rows(0)("HPI_InterSensit")
        'data(2) = dvCan.Table.Rows(0)("HPI_Prudence")
        'data(1) = dvCan.Table.Rows(0)("HPI_Inquisitive")
        'data(0) = dvCan.Table.Rows(0)("HPI_LearnApprch")
        For i1 = 0 To 6
            data(i1) = dvCan.Table.Rows(0)("HPI" & (7 - i1))
        Next
        'Draw
        Dim c As XYChart = New XYChart(600, 350, &HE0E0FF, &HCCCCFF, 1)
        c.setPlotArea(60, 45, 500, 210, &HFFFFFF)

        c.swapXY()
        c.addBarLayer3(data)


        ' Add a title to the y axis using 11 pt Times Bold Italic as font
        c.yAxis().setTitle("Revenue (millions)", "Times New Roman Bold Italic", 11)
        c.syncYAxis()

        ' Set the labels on the x axis
        c.xAxis().setLabels(labels)
        c.xAxis().setLabelStyle("Arial Bold", 10)

        ' Disable x-axis ticks by setting the tick length to 0
        c.xAxis().setTickLength(0)



        ' Output the chart
        'WebChartViewer1.Image = c.makeWebImage(Chart.PNG)

    End Sub

    'Protected Sub tabChart_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabChart.RowDataBound
    '    If e.Row.RowType = DataControlRowType.DataRow Then
    '    ElseIf e.Row.RowType = DataControlRowType.Header Then
    '        e.Row.Cells(0).Text = sScales
    '        e.Row.Cells(1).Text = sPercentiles
    '        e.Row.Cells(0).Style.Add("padding", "6px;")
    '        e.Row.Cells(1).Style.Add("padding", "6px;")
    '        Exit Sub
    '    Else
    '        Exit Sub
    '    End If

    '    'insert header image
    '    If e.Row.RowIndex = 0 Then
    '        Dim gr As GridViewRow, tbl1 As Table, tc1 As TableCell
    '        gr = New GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal)
    '        tbl1 = e.Row.Parent
    '        tbl1.Rows.AddAt(e.Row.RowIndex + 1, gr)
    '        tc1 = New TableCell
    '        tc1.ColumnSpan = 2
    '        tc1.Text = "<b>" & "insert 0-100 scale here" & "</b>"
    '        tc1.HorizontalAlign = HorizontalAlign.Center
    '        tc1.CssClass = "selrow"

    '        Trace.Warn("Inserted ")
    '        gr.Cells.Add(tc1)
    '    End If


    '    'L1 = e.Row.FindControl("Score")
    '    'L1.Text = dvCan.Table.Rows(0)("HPI" & (e.Row.RowIndex + 1))
    '    e.Row.Cells(0).Style.Add("padding", "6px;")
    '    e.Row.Cells(1).Style.Add("background-image", "url(../images/hpi_lines.jpg)")

    '    'e.Row.Cells(1).Style.Add("position", "relative")
    '    'e.Row.Cells(1).Style.Add("z-index", "-1")

    '    'e.Row.Cells(1).Style.Add("border-bottom", "2px solid black;")
    '    Dim div1 As HtmlGenericControl
    '    div1 = e.Row.Cells(1).FindControl("div1")

    '    'insert blue/orange bar
    '    div1.Controls.Add(Bar_Get(e.Row.DataItem("Score"), e.Row.DataItem("IsLF")))

    '    'insert grey bar
    '    If e.Row.DataItem("GreyMin") > 0 Then
    '        div1.Controls.Add(GreyBar_get(e.Row.DataItem("GreyMin"), e.Row.DataItem("GreyMax")))
    '    End If

    'End Sub

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



        T1.BgColor = "#EEEEEE"
        T1.Height = 19
        tr1 = New HtmlTableRow
        T1.Rows.Add(tr1)

        tc1 = New HtmlTableCell
        tr1.Cells.Add(tc1)
        tc1.Align = "right"
        tc1.InnerHtml = "<font ""size=1px;""> </font>"

        GreyBar_get = T1
    End Function


    Function Genderize(ByVal s1 As String) As String
        Genderize = Replace(s1, "|Name|", sCandidateName)
        Genderize = Replace(Genderize, "|Firstname|", sFirstName)
        Genderize = Replace(Genderize, "|he|", Me.gender_he.Text)
        Genderize = Replace(Genderize, "|He|", Me.gender_he2.Text)
        Genderize = Replace(Genderize, "|him|", Me.gender_him.Text)
        Genderize = Replace(Genderize, "|his|", Me.gender_his.Text)
        Genderize = Replace(Genderize, "|His|", Me.gender_his2.Text)
        Genderize = Replace(Genderize, "|Mr|", Me.gender_mr.Text)
        Genderize = Replace(Genderize, "|himself|", Me.gender_himself.Text)
        Genderize = Replace(Genderize, "|Surname|", sLastName)

    End Function

    Sub Overview_Load()
        Dim dvO As System.Data.DataView
        Dim i1 As Integer, iWhich As Integer

        dvO = Me.rsCanText.Select(DataSourceSelectArguments.Empty)
        For i1 = 0 To dvO.Table.Rows.Count - 1
            If IsNumeric(Left(System.Guid.NewGuid().ToString(), 1)) Then
                iWhich = 1
            Else
                iWhich = 2
            End If


            If i1 = 4 Then
                Me.overviewparas.Text = Me.overviewparas.Text & "<br><br>"
            Else
                Me.overviewparas.Text = Me.overviewparas.Text & " "
            End If
            Me.overviewparas.Text = Me.overviewparas.Text & dvO.Table.Rows(i1)("Overview" & iWhich)
        Next
        Me.overviewparas.Text = Genderize(Me.overviewparas.Text)
    End Sub


    Sub tabGaps_Bind()
        Trace.Warn("Binding gaps")
        Dim dv2 As System.Data.DataView
        dvCanText = Me.rsCanText.Select(DataSourceSelectArguments.Empty)
        dv2 = New System.Data.DataView(dvCanText.Table, "", "GapScore Desc, ScaleID asc", System.Data.DataViewRowState.CurrentRows)

        For i1 = 0 To dv2.Count - 1
            Trace.Warn(dv2(i1)("GapScore"))
        Next
        Me.tabGaps.DataSource = dv2
        Me.tabGaps.DataBind()
    End Sub

    Protected Sub tabGaps_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabGaps.ItemDataBound
        If e.Item.ItemIndex = 0 Then
            Dim L1 As Label
            L1 = e.Item.FindControl("hpi_gaps")
            L1.Text = shpi_gaps
        Else
            Dim trlabel As HtmlTableRow
            trlabel = e.Item.FindControl("tr1")
            trlabel.Visible = False
        End If

        If e.Item.ItemIndex > 3 Then
            e.Item.Controls.Clear()
        End If
    End Sub

    Protected Sub tabLFDetail_ItemCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabLFDetail.ItemCreated
        sScaleName = e.Item.DataItem("ScaleName")

    End Sub

    'Protected Sub tabLFDetail_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabLFDetail.ItemDataBound
    '    'L1 = e.Item.FindControl("hpi_leaderfitanalysis")
    '    'L1.Text = sLeaderfitAnalysis
    '    Dim bHasList1 As Boolean, bHaslist2 As Boolean

    '    If e.Item.DataItem("IsHogan") = 1 Then
    '        e.Item.Controls.Clear()
    '        Exit Sub
    '    End If


    '    uc1 = e.Item.FindControl("ph5")
    '    uc1.pCName = sCandidateName
    '    uc1.pReportName = sReportName

    '    L1 = e.Item.FindControl("hpi_demonstratedstrengths")
    '    L1.Text = sDemonstratedStrengths

    '    L1 = e.Item.FindControl("hpi_areastodevelop")
    '    L1.Text = sAreastoDevelop

    '    'Demonstrated Strengths and Areas to Develop
    '    Dim listDS As HtmlTable, listAD As HtmlTable
    '    Dim iWhich As Integer
    '    listDS = e.Item.FindControl("list1")
    '    listAD = e.Item.FindControl("list2")

    '    bHasList1 = False
    '    bHaslist2 = False
    '    For i1 = 0 To dvCanText.Table.Rows.Count - 1
    '        iWhich = e.Item.DataItem("ScaleID")

    '        If dvCanText.Table.Rows(i1)("IsSTrength" & iWhich) = "1" Then
    '            'listDS.Items.Add(li)
    '            bHasList1 = True
    '            Bullet_Add(listDS, Genderize(dvCanText.Table.Rows(i1)("LF" & iWhich)))
    '        Else
    '            'listAD.Items.Add(li)
    '            bHaslist2 = True
    '            Bullet_Add(listAD, Genderize(dvCanText.Table.Rows(i1)("LF" & iWhich)))
    '        End If
    '        'li.Text = Genderize(dvCanText.Table.Rows(i1)("LF" & iWhich))
    '    Next

    '    'None reported
    '    If bHasList1 = False Then Bullet_Add(listDS, "none")

    '    If bHaslist2 = False Then Bullet_Add(listAD, "none")

    'End Sub


    Protected Sub tabLFDetail_ItemDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabLFDetail.ItemDataBound
        'L1 = e.Item.FindControl("hpi_leaderfitanalysis")
        'L1.Text = sLeaderfitAnalysis
        Dim dvLFText As System.Data.DataView, sText As String

        If dvLFText Is Nothing Then
            dvCanText = Me.rsCanText.Select(DataSourceSelectArguments.Empty)
            dvLFText = CF.DataView_Get("Select * from qryLFText where CandidateID=" & Request.QueryString("CandidateID") & " order by HPIScaleID")
        End If

        If e.Item.DataItem("IsHogan") = 1 Then
            e.Item.Controls.Clear()
            Exit Sub
        End If

        uc1 = e.Item.FindControl("ph5")
        uc1.pCName = sCandidateName
        uc1.pReportName = sReportName
        uc1.pLF_TM = sLF_TM

        L1 = e.Item.FindControl("hpi_relatedcompetencies")
        L1.Text = sRelatedCompetencies
        L1 = e.Item.FindControl("hpi_individualanalysis")
        L1.Text = sIndividualAnalysis

        'Demonstrated Strengths 
        Dim listDS As HtmlTable, listIA As HtmlTable, a1() As String, j1 As Integer
        listDS = e.Item.FindControl("list1")
        For i1 = 0 To dvLFText.Table.Rows.Count - 1
            If dvLFText.Table.Rows(i1)("LFScaleID") = e.Item.DataItem("ScaleID") Then
                sText = dvLFText.Table.Rows(i1)("LFBullets")
                a1 = Split(sText, vbCrLf)
                For j1 = 0 To UBound(a1)
                    If Trim(a1(j1)) <> "" Then Bullet_Add(listDS, Genderize(a1(j1)))
                Next

                Exit For 'this is needed because the dataview has two entries per LF Scale
            End If
        Next


        'Individual Analysis
        listIA = e.Item.FindControl("list2")
        For i1 = 0 To dvLFText.Table.Rows.Count - 1
            If dvLFText.Table.Rows(i1)("LFScaleID") = e.Item.DataItem("ScaleID") Then
                sText = dvLFText.Table.Rows(i1)("LevelName") & "text"
                sText = dvLFText.Table.Rows(i1)(sText)
                Bullet_Add(listIA, Genderize(sText))
            End If
        Next

    End Sub

    Sub Bullet_Add(tbl1 As HtmlTable, sText As String)
        Dim tr1 As HtmlTableRow, tc1 As HtmlTableCell, img1 As HtmlImage

        tr1 = New HtmlTableRow
        tbl1.Rows.Add(tr1)

        tc1 = New HtmlTableCell
        tr1.Cells.Add(tc1)
        tc1.VAlign = "top"
        tc1.Style.Add("padding-top", "6px;")
        tc1.Style.Add("padding-right", "10px;")

        If sText = "none" Then
            tc1.Width = 8

        Else
            img1 = New HtmlImage
            tc1.Controls.Add(img1)
            img1.Src = "../images/bullet.jpg"
            img1.Width = 5
        End If


        tc1 = New HtmlTableCell
        tr1.Cells.Add(tc1)
        tc1.VAlign = "top"
        If sText = "none" Then
            tc1.InnerHtml = "<i>" & sNodata & "</i>"
        Else
            tc1.InnerHtml = sText '& "<br>&nbsp;"
        End If


    End Sub

    Protected Sub tabHogan_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabHogan.ItemDataBound
        If e.Item.DataItem("IsHogan") = 0 Then
            e.Item.Controls.Clear()
            Exit Sub
        End If

        If ShowHDS = False And e.Item.DataItem("ScaleType") = "HDS" Then
            e.Item.Controls.Clear()
            Exit Sub
        End If

        If ShowMVPI = False And e.Item.DataItem("ScaleType") = "MVPI" Then
            e.Item.Controls.Clear()
            Exit Sub
        End If

        If ShowMVPI = False And ShowHDS = False And e.Item.DataItem("ScaleType") = "HPI" Then
            e.Item.Controls.Clear()
            Exit Sub
        End If
    End Sub

    Protected Sub tabStrengths_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabStrengths.ItemDataBound
        If e.Item.ItemIndex = 0 Then
            Dim L1 As Label
            L1 = e.Item.FindControl("hpi_strengths")
            L1.Text = shpi_strengths
        Else
            Dim trlabel As HtmlTableRow
            trlabel = e.Item.FindControl("tr1")
            trlabel.Visible = False
        End If
    End Sub





    Protected Sub tabLF_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabLF.ItemDataBound
        If e.Item.DataItem("IsHogan") = 1 Then

            e.Item.Controls.Clear()
            Exit Sub
        End If

        L1 = e.Item.FindControl("PageNo")
        'If True Then 'dvCan.Table.Rows(0)("AssgnTypeID") = 30 Then
        If ShowGraph Then
            L1.Text = e.Item.DataItem("ScaleID") + 5
        Else
            L1.Text = e.Item.DataItem("ScaleID") + 4
        End If

    End Sub


    Protected Sub tabHDS1_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabHDS1.ItemDataBound
        If e.Item.ItemIndex > cHDSCount Then
            e.Item.Controls.Clear()
            Me.pHDS2.Visible = True
            Me.hds_continued1.Visible = True
            Exit Sub
        End If


        'image
        'Dim img1 As HtmlImage
        'img1 = e.Item.FindControl("img1")
        'img1.Src = "../images/" & e.Item.DataItem("Levelname") & ".jpg"
        'img1.Height = 20
    End Sub

    Protected Sub tabHDS2_ItemDataBound(sender As Object, e As System.Web.UI.WebControls.RepeaterItemEventArgs) Handles tabHDS2.ItemDataBound
        If e.Item.ItemIndex <= cHDSCount Then
            e.Item.Controls.Clear()
            Exit Sub
        End If



        'image
        'Dim img1 As HtmlImage
        'img1 = e.Item.FindControl("img1")
        'img1.Src = "../images/" & e.Item.DataItem("Levelname") & ".jpg"
        'img1.Height = 20
    End Sub

    Protected Sub tabMVPI1_PreRender(sender As Object, e As System.EventArgs) Handles tabMVPI1.PreRender
        If Me.tabMVPI1.Items.Count = 0 Then
            Me.mvpi_nodata.Text = sNodata
        End If
    End Sub

    Protected Sub tabLFSumm_RowDataBound(sender As Object, e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles tabLFSumm.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.DataItem("IsHogan") = 1 Then
                e.Row.Controls.Clear()
                Exit Sub
            End If

        ElseIf e.Row.RowType = DataControlRowType.Header Then
            e.Row.Cells(0).Text = slf_dimension
            e.Row.Cells(1).Text = slf_hogancomps
            e.Row.Cells(2).Text = slf_hpiscales
        End If

        'e.Row.Style.Add("border-bottom", "2px solid black;")
        e.Row.Cells(0).Style.Add("border-bottom", "2px solid black;")
        e.Row.Cells(1).Style.Add("border-bottom", "2px solid black;")
        e.Row.Cells(2).Style.Add("border-bottom", "2px solid black;")
    End Sub
End Class
