<%@ Page Language="VB" Trace="false" Debug="false" EnableViewState="False" MasterPageFile="Leaderfit.master"
    AutoEventWireup="false" StylesheetTheme="creative" CodeFile="Report_Benchmark.aspx.vb"
    Inherits="CustomRpt_Report_HPI2" Title="Untitled Page" %>

<%@ Register Assembly="netchartdir" Namespace="ChartDirector" TagPrefix="chart" %>
<%@ Register TagName="ph" TagPrefix="uc" Src="ph.ascx" %>
<%@ Register TagName="phtitle" TagPrefix="uc" Src="ph_title.ascx" %>
<%@ Register TagName="lfchart" TagPrefix="uc" Src="lfchart.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Label runat="server" ID="hpi_appendix" Visible="false"></asp:Label>
    <asp:Label runat="server" ID="gender_he" Visible="False"></asp:Label>
    <asp:Label runat="server" ID="gender_himself" Visible="False"></asp:Label>
    <asp:Label runat="server" ID="gender_him" Visible="False"></asp:Label>
    <asp:Label runat="server" ID="gender_he2" Visible="False"></asp:Label>
    <asp:Label runat="server" ID="gender_his" Visible="False"></asp:Label>
    <asp:Label runat="server" ID="gender_his2" Visible="False"></asp:Label>
    <asp:Label runat="server" ID="gender_mr" Visible="False"></asp:Label>
    <asp:SqlDataSource ID="rsCan" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [CandidateID], [FirstName], [LastName], Gender, ClientName, AssgnDesc, Valid, DateLFGenerated, HoganSections, AssgnTypeID, LanguageID FROM [qryCan_Assgn] WHERE ([CandidateID] = @CandidateID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" DefaultValue="1"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel runat="server" ID="pMain" Width="800">
        <!-- Cover page -->
        <table width="800" border="0">
            <tr>
                <td width="350" valign="bottom" align="left" style="padding-left: 90px;">
                    <img alt="" src="../images/Grid-Logo-Large.jpg" width="120" />
                </td>
                <td width="450" valign="bottom" align="left">
                    <img alt="" src="../images/LeaderFit-Logo.jpg" width="320" />
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-top: 50px;">
                    <img runat="server" id="CoverImage" alt="" src="../images/TitlePage-Header-Blue.jpg"
                        width="800" />
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td style="padding-top: 100px;">
                    <asp:Label runat="server" ID="ReportName" CssClass="h2"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td style="padding-top: 25px;">
                    <asp:Label runat="server" ID="CName4" CssClass="titlepageblock" Text="Pat Sample"></asp:Label>
                    <br />
                    <asp:Label runat="server" ID="ClientName" CssClass="titlepageblock" Text="Pat Sample"></asp:Label>
                    <br />
                    <asp:Label runat="server" ID="AssgnName" CssClass="titlepageblock" Text="Pat Sample"></asp:Label>
                    <br />
                    <asp:Label runat="server" ID="Reportdate" CssClass="titlepageblock" Text="Pat Sample"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                </td>
                <td valign="top" align="left" valign="bottom" height="150" style="padding-top: 50px;">
                    <img runat="server" id="ClientImage" width="250" border="0" />
                </td>
            </tr>
        </table>
        <table width="800" border="0">
            <tr>
                <td width="50">
                </td>
                <td valign="bottom">
                    <img alt="" src="../images/Hogan-Logo.jpg" width="400" />
                </td>
                <td valign="bottom" align="right" style="padding-top: 90px;">
                    <img alt="" src="../images/Odgers-Logo.jpg" width="280" />
                </td>
            </tr>
        </table>
        <!-- Methodology -- page break intentionally removed-->
        <p>
            &nbsp;</p>
        <uc:ph runat="server" ID="ph1" />
        <uc:phtitle runat="server" ID="phtitle1" pColorName="Cyan" />
        <asp:SqlDataSource runat="server" ID="rsLF" ConnectionString="<%$ ConnectionStrings:cMain %>"
            SelectCommand="SELECT [ScaleID], [ScaleName], [ScaleDesc], ScaleType, IsHogan, HoganComps, HPIScales FROM [qryCan_Scales] WHERE ([CandidateID] = @CandidateID) ORDER BY [ScaleID]">
            <SelectParameters>
                <asp:QueryStringParameter DefaultValue="1" Name="CandidateID" QueryStringField="CandidateID"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div style="padding-left: 90px; padding-right: 50px;">
            <table width="100%" border="0">
                <tr>
                    <td valign="top" width="300">
                        <asp:Label runat="server" ID="hpi_methodology" CssClass="h3"></asp:Label>
                        <br />
                        <asp:Label runat="server" ID="methodologyintro"></asp:Label>
                        <asp:Label runat="server" ID="methodologyintro2"></asp:Label>
                        <br />
                        <br />
                        <asp:Repeater runat="server" ID="tabHogan" DataSourceID="rsLF">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="ScaleName" Text='<%# Eval("ScaleName") %>' CssClass="h4single"></asp:Label>
                                <div style="height: 6px">
                                </div>
                                <asp:Label runat="server" ID="ScaleDesc" Text='<%# Eval("ScaleDesc") %>'></asp:Label><br />
                                <br />
                            </ItemTemplate>
                        </asp:Repeater>
                    </td>
                    <td width="40">
                        &nbsp;
                    </td>
                    <td valign="top" width="300">
                        <asp:Label runat="server" ID="benchmark_reportorganization" CssClass="h3"></asp:Label>
                        <br />
                        <asp:Label runat="server" ID="benchmark_reportintro"></asp:Label>
                        <br />
                        <br />
                        <table cellpadding="2" cellspacing="0" width="100%" border="0">
                            <tr>
                                <td colspan="3" class="h4">
                                    <asp:Label runat="server" ID="toc_section1"></asp:Label>
                                    I
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label runat="server" ID="benchmark_p2"></asp:Label>
                                </td>
                                <td width="10">
                                </td>
                                <td align="right" valign="top">
                                    2
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label runat="server" ID="hpi_strengthsgaps"></asp:Label>
                                </td>
                                <td width="10">
                                </td>
                                <td align="right" valign="top">
                                    3
                                </td>
                            </tr>
                            <tr>
                                <td valign="top">
                                    <asp:Label runat="server" ID="benchmark_leaderfitanalysis_notm"></asp:Label>
                                </td>
                                <td width="10">
                                </td>
                                <td align="right" valign="top">
                                    4
                                </td>
                            </tr>
                            <tr runat="server" id="toc_leaderfit">
                                <td valign="top" style="padding-left: 25px;">
                                    <asp:Label runat="server" ID="benchmark_leaderfitanalysissummary_notm"></asp:Label>
                                </td>
                                <td width="10">
                                </td>
                                <td align="right" valign="top">
                                    5
                                </td>
                            </tr>
                            <asp:Repeater runat="server" ID="tabLF" DataSourceID="rsLF">
                                <ItemTemplate>
                                    <tr>
                                        <td valign="top" style="padding-left: 25px;">
                                            <asp:Label runat="server" ID="ScaleName" Text='<%# Eval("ScaleName") %>'></asp:Label>
                                        </td>
                                        <td width="10">
                                        </td>
                                        <td valign="top" align="right">
                                            <asp:Label runat="server" ID="Pageno" Text='<%# Eval("ScaleID")+5 %>'></asp:Label>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                            <tr>
                                <td colspan="3">
                                    <br />
                                    <br />
                                </td>
                            </tr>
                            <tr runat="server" id="toc_section2">
                                <td colspan="3" class="h4">
                                    <asp:Label runat="server" ID="toc_section2a"></asp:Label>
                                    II
                                </td>
                            </tr>
                            
                            <tr runat="server" id="toc_hds">
                                <td valign="top">
                                    <asp:Label runat="server" ID="hds_title2"></asp:Label>
                                </td>
                                <td width="10">
                                </td>
                                <td align="right" valign="top">
                                    <asp:Label runat="server" ID="pageno_hds"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="toc_mvpi">
                                <td valign="top">
                                    <asp:Label runat="server" ID="mvpi_title2"></asp:Label>
                                </td>
                                <td width="10">
                                </td>
                                <td align="right" valign="top">
                                    <asp:Label runat="server" ID="pageno_mvpi"></asp:Label>
                                </td>
                            </tr>
                            <tr runat="server" id="toc_careerdev">
                                <td valign="top">
                                    <asp:Label runat="server" ID="hpi_careerdev2"></asp:Label>
                                </td>
                                <td width="10">
                                </td>
                                <td align="right" valign="top">
                                    <asp:Label runat="server" ID="pageno_careerdev"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <br />
                                    <br />
                                    <br />
                                    <center>
                                        <asp:Label runat="server" ID="hpi_note" Font-Italic="true"></asp:Label>
                                    </center>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- Overview -->
        <p class="newpage">&nbsp;
        </p>
        <uc:ph runat="server" ID="ph2" />
        <uc:phtitle runat="server" ID="phtitle2" pColorName="Cyan" />
        <asp:Label runat="server" ID="hpi_overviewtitle" Visible="false"></asp:Label>
        <asp:SqlDataSource runat="server" ID="rsCanText" ConnectionString="<%$ ConnectionStrings:cMain %>"
            SelectCommand="SELECT [CandidateID], [ScaleID], [Score], GapScore, [LevelName], [Overview1], [Overview2], Strengths, Gaps, ScaleName, ScaleDesc, LF1, LF2, LF3, LF4, LF5, IsStrength1, IsStrength2, IsStrength3, IsStrength4, IsStrength5, isLF, GreyMin, GreyMax, CareerDevText FROM [qryCandidateText] WHERE ([CandidateID] = @CandidateID) ORDER BY [ScaleID]">
            <SelectParameters>
                <asp:QueryStringParameter Name="CandidateID" DefaultValue="1" QueryStringField="CandidateID"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <div style="padding-left: 90px; padding-right: 50px;">
            <table width="100%" border="0">
                <tr>
                    <td>
                        <asp:Label runat="server" ID="hpi_overview" CssClass="h3"></asp:Label>
                    </td>
                    <td width="20">
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Label runat="server" ID="overviewparas"></asp:Label>
                    </td>
                    <td>
                    </td>
                    <td valign="top" class="blockquote">
                        <asp:Label runat="server" ID="hpi_overviewpullout"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
        <!-- Leadership strengths and gaps -->
        <p class="newpage">&nbsp;
        </p>
        <uc:ph runat="server" ID="ph3" />
        <uc:phtitle runat="server" ID="phtitle3" pColorName="Cyan" />
        <div style="padding-left: 90px; padding-right: 50px;">
            <asp:Label runat="server" ID="hpi_strengthsgapsintro"></asp:Label><br />
            <br />
            <table cellpadding="0" cellspacing="0" border="0">
                <tr>
                    <td valign="top" width="310">
                        <table border="0">
                            <asp:Repeater runat="server" ID="tabStrengths" DataSourceID="rsCanText">
                                <ItemTemplate>
                                    <tr runat="server" id="tr1">
                                        <td colspan="2">
                                            <asp:Label runat="server" ID="hpi_strengths" CssClass="h3a" Text="Strengths"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="padding-right: 10px;">
                                            <img alt="" alt="" src="../images/bullet.JPG" width="5" />
                                        </td>
                                        <td valign="top" style="padding-top: 5px;">
                                            <asp:Label runat="server" ID="Strengths" Text='<%# Genderize(Eval("Strengths")) %>'></asp:Label><br />
                                            &nbsp;
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </td>
                    <td width="30">
                    </td>
                    <td align="left" valign="top" width="310">
                        <table cellpadding="0" cellspacing="0">
                            <asp:Repeater runat="server" ID="tabGaps">
                                <ItemTemplate>
                                    <tr runat="server" id="tr1">
                                        <td colspan="2">
                                            <asp:Label runat="server" ID="hpi_gaps" CssClass="h3" Text="Gaps"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="padding-right: 10px;">
                                            <img alt="" alt="" src="../images/bullet.JPG" width="5" />
                                        </td>
                                        <td valign="top" style="padding-top: 4px;">
                                            <asp:Label runat="server" ID="GapScore" Text='<%# Eval("Gapscore") %>' Visible="false"></asp:Label>
                                            <asp:Label runat="server" ID="Gaps" Text='<%# Genderize(Eval("Gaps")) %>'></asp:Label><br />
                                            &nbsp;
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </table>
                    </td>
                </tr>
            </table>
        </div>
        <!-- Leaderfit Intro -->
        <p class="newpage">&nbsp;
        </p>
        <uc:ph runat="server" ID="ph4" />
        <uc:phtitle runat="server" ID="phtitle4" pColorName="Orange" pPageTitle='<%# Eval("ScaleName") %>' />
        <asp:Label runat="server" ID="benchmark_leaderfitanalysis" Visible="false"></asp:Label>
        <div style="padding-left: 90px; padding-right: 50px; padding-bottom: 20px;">
            <asp:Label runat="server" ID="benchmark_lfintro"></asp:Label></div>
        <center>
            <img alt="" src="../images/Infographic-EN.jpg" runat="server" id="lf_image" /></center>
        <!-- LeaderFit Chart (German) page -->
        <div runat="server" id="div_lfchart" style="display: inline;">
            <p class="newpage">&nbsp;
            </p>
            <uc:ph runat="server" ID="ph1a" />
            <uc:phtitle runat="server" ID="phtitle1a" pColorName="Orange" />
            <asp:Label runat="server" ID="benchmark_leaderfitanalysissummary" Visible="false"></asp:Label>
            <div style="padding-left: 90px; padding-right: 50px;">
                <asp:Label runat="server" ID="lf_chartintro"></asp:Label>
                <br />
                <br />
                <asp:GridView runat="server" ID="tabLFSumm" DataSourceID="rsLF" GridLines="None"
                    CellPadding="6" CellSpacing="0" HeaderStyle-HorizontalAlign="Left" ShowHeader="true"
                    AutoGenerateColumns="false" HeaderStyle-CssClass="h3a">
                    <Columns>
                        <asp:BoundField DataField="ScaleName" HeaderText="LeaderFit Dimension" ItemStyle-CssClass="h4a"
                            ItemStyle-VerticalAlign="Top" />
                        <asp:BoundField DataField="HoganComps" HeaderText="Definition" ItemStyle-VerticalAlign="Top" />
                        <asp:BoundField DataField="HPIScales" HeaderText="Related HOGAN Scales" ItemStyle-VerticalAlign="Top" />
                    </Columns>
                </asp:GridView>
                <br />
                <br />
                <uc:lfchart runat="server" ID="lfchart1" />
            </div>
        </div>
        <!-- Leaderfit Detail -->
        <asp:Repeater runat="server" ID="tabLFDetail" DataSourceID="rsLF">
            <ItemTemplate>
                <p class="newpage">&nbsp;
                </p>
                <uc:ph runat="server" ID="ph5" />
                <uc:phtitle runat="server" ID="phtitle5" pColorName="Orange" pPageTitle='<%# Eval("ScaleName") %>' />
                <div style="padding-left: 90px; padding-right: 50px;">
                    <asp:Label runat="server" ID="ScaleDesc" Text='<%# Eval("ScaleDesc") %>' CssClass="blockquote"
                        Width="500"></asp:Label>
                    <br />
                    <br />
                    <asp:Label runat="server" ID="hpi_relatedcompetencies" CssClass="h3"></asp:Label>
                    <br />
                    <table width="100%" runat="server" id="list1" border="0">
                    </table>
                    <br />
                    <br />
                    <asp:Label runat="server" ID="hpi_individualanalysis" CssClass="h3"></asp:Label>
                    <br />
                    <table width="100%" runat="server" id="list2" border="0">
                    </table>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        
        <!-- Benchmark HDS page 1 -->
        <asp:Panel runat="server" ID="pHDS1">
            <p class="newpage">&nbsp;
            </p>
            <uc:ph runat="server" ID="ph6" />
            <uc:phtitle runat="server" ID="phtitle6" pColorName="Cyan" />
            <div style="padding-left: 90px; padding-right: 50px;">
                <asp:Label runat="server" ID="hds_intro"></asp:Label><br />
                <br />
                <br />
                <asp:SqlDataSource runat="server" ID="rsHDS" ConnectionString="<%$ ConnectionStrings:cMain %>"
                    SelectCommand="CanHDS_Get" SelectCommandType="StoredProcedure">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" Type="Int32"
                            DefaultValue="1" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <table width="100%">
                    <asp:Repeater runat="server" ID="tabHDS1" DataSourceID="rsHDS">
                        <ItemTemplate>
                            <tr>
                                <td valign="top" width="100">
                                    <asp:Label runat="server" ID="Scalename" Text='<%# (Eval("ScaleName")) %>' CssClass="h4"></asp:Label>
                                </td>
                                <%--<td valign="top" align="center" width="40" style="padding-top: 5px;">
                                    <img runat="server" id="img1" />
                                </td>--%>
                                <td valign="top" style="padding-bottom: 15px;">
                                    <asp:Label runat="server" ID="JobRiskDesc" Text='<%# Genderize(Eval("JobRiskDesc")) %>'></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td colspan="3" align="right" style="padding-top: 30px;">
                            <asp:Label runat="server" ID="hds_continued1" Visible="false"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <!-- Benchmark HDS page 2 -->
        <asp:Panel runat="server" ID="pHDS2" Visible="false">
            <p class="newpage">&nbsp;
            </p>
            <uc:ph runat="server" ID="ph5" />
            <uc:phtitle runat="server" ID="phtitle5" pColorName="Cyan" />
            <div style="padding-left: 90px; padding-right: 50px;">
                <br />
                <br />
                <table width="100%">
                    <tr>
                        <td colspan="3" style="padding-bottom: 40px;">
                            <asp:Label runat="server" ID="hds_continued2"></asp:Label>
                        </td>
                    </tr>
                    <asp:Repeater runat="server" ID="tabHDS2" DataSourceID="rsHDS">
                        <ItemTemplate>
                            <tr>
                                <td valign="top" width="100">
                                    <asp:Label runat="server" ID="Scalename" Text='<%# (Eval("ScaleName")) %>' CssClass="h4"></asp:Label>
                                </td>
                                <%--<td valign="top" align="center" width="40" style="padding-top: 5px;">
                                    <img runat="server" id="img1" />
                                </td>--%>
                                <td valign="top" style="padding-bottom: 15px;">
                                    <asp:Label runat="server" ID="JobRiskDesc" Text='<%# Genderize(Eval("JobRiskDesc")) %>'></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </asp:Panel>


        <!-- Benchmark MVPI -->
        <asp:Panel runat="server" ID="pMVPI1">
            <p class="newpage">&nbsp;
            </p>
            <uc:ph runat="server" ID="ph7" />
            <uc:phtitle runat="server" ID="phtitle7" pColorName="Cyan" />
            <asp:SqlDataSource runat="server" ID="rsMVPI" ConnectionString="<%$ ConnectionStrings:cMain %>"
                SelectCommand="CanMVPI_Get" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" Type="Int32"
                        DefaultValue="1" />
                </SelectParameters>
            </asp:SqlDataSource>
            <div style="padding-left: 90px; padding-right: 50px;">
                <table border="0">
                    <tr>
                        <td colspan="2" style="padding-bottom: 10px;">
                            <asp:Label runat="server" ID="mvpi_intro"></asp:Label><br />
                            &nbsp;
                        </td>
                    </tr>
                    <asp:Repeater runat="server" ID="tabMVPI1" DataSourceID="rsMVPI">
                        <ItemTemplate>
                            <tr>
                                <td valign="top" width="100">
                                    <asp:Label runat="server" ID="ScaleName" CssClass="h4" Text='<%# (Eval("ScaleName")) %>'></asp:Label>
                                </td>
                                <td style="padding-bottom: 15px;">
                                    <asp:Label runat="server" ID="Overview"></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr>
                        <td colspan="2" align="left" style="padding-left: 30px; padding-top: 30px;">
                            <asp:Label runat="server" ID="mvpi_nodata" Font-Italic="true"></asp:Label>
                        </td>
                    </tr>
                </table>
            </div>
        </asp:Panel>
        <!-- Career Dev -->
        <asp:Panel runat="server" ID="pCareerDev">
            <p class="newpage">&nbsp;
            </p>
            <uc:ph runat="server" ID="ph10" />
            <uc:phtitle runat="server" ID="phtitle10" pColorName="Cyan" />
            <asp:Label runat="server" ID="hpi_careerdev" Visible="false"></asp:Label>
            <div style="padding-left: 90px; padding-right: 50px;">
                <asp:Label runat="server" ID="careerdev_intro"></asp:Label><br />
                <br />
                <table width="100%" cellpadding="4" cellspacing="0">
                    <asp:Repeater runat="server" ID="tabCareerDev" DataSourceID="rsCanText">
                        <ItemTemplate>
                            <tr>
                                <td valign="top" style="padding-right: 10px;">
                                    <img src="../images/bullet.jpg" width="5" />
                                </td>
                                <td valign="top" style="padding-bottom: 15px; padding-top: 6px;">
                                    <asp:Label runat="server" ID="CareerDevText" Text='<%# Eval("CareerDevText") %>'></asp:Label>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                </table>
            </div>
        </asp:Panel>
    </asp:Panel>
</asp:Content>
