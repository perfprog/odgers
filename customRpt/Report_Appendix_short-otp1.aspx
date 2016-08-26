<%@ Page Language="VB" Trace="true" Debug="true" EnableViewState="False" MasterPageFile="Leaderfit.master"
    AutoEventWireup="false" StylesheetTheme="creative" CodeFile="Report_Appendix_short-otp1.aspx.vb"
    Inherits="CustomRpt_Report_HPI" Title="Untitled Page"  %>

<%@ Register Assembly="netchartdir" Namespace="ChartDirector" TagPrefix="chart" %>
<%@ Register TagName="ph" TagPrefix="uc" Src="ph.ascx" %>
<%@ Register TagName="phtitle" TagPrefix="uc" Src="ph_title_appendix.ascx" %>
<%@ Register TagName="lfchart" TagPrefix="uc" Src="lfchart.ascx" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsCan" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [CandidateID], [FirstName], [LastName], Gender, ClientName, AssgnName, Valid, DateLFGenerated, LanguageID FROM [qryCan_Assgn] WHERE ([CandidateID] = @CandidateID)">
        <SelectParameters>
            <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" DefaultValue="1"
                Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:Panel runat="server" ID="pMain" Width="800">
        <asp:SqlDataSource runat="server" ID="rsCanText" ConnectionString="<%$ ConnectionStrings:cMain %>"
            SelectCommand="SELECT [CandidateID], [ScaleID], [Score], GapScore, [LevelName], [Overview1], [Overview2], Strengths, Gaps, ScaleName, ScaleDesc, LF1, LF2, LF3, LF4, LF5, IsStrength1, IsStrength2, IsStrength3, IsStrength4, IsStrength5, isLF, GreyMin, GreyMax FROM [qryCandidateText] WHERE ([CandidateID] = @CandidateID) ORDER BY [ScaleID]">
            <SelectParameters>
                <asp:QueryStringParameter Name="CandidateID" DefaultValue="1" QueryStringField="CandidateID"
                    Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>
        <!-- Hogan Scores -->
        <uc:ph runat="server" ID="ph10" />
        <uc:phtitle runat="server" ID="phtitle10" pColorName="Cyan" />
        <asp:Label runat="server" ID="appendix_scores" Visible="false"></asp:Label>
        <div style="padding-left: 50px; padding-right: 20px;">
            <asp:SqlDataSource runat="server" ID="rsHoganData" ConnectionString="<%$ ConnectionStrings:cMain %>"
                SelectCommand="SELECT [CandidateID], [ScaleType], [ScaleID], [ScaleName], [ScaleDesc], [Score], ScaleName2 FROM [qryCandidateData_Hogan] WHERE Scaleid>0 and ([CandidateID] = @CandidateID) ORDER BY [ScaleOrder], [ScaleID]">
                <SelectParameters>
                    <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView runat="server" ID="tabHoganData" DataSourceID="rsHoganData" AutoGenerateColumns="false"
                GridLines="Both" BorderColor="Black" BorderStyle="Solid" BorderWidth="1" CellPadding="2"
                CellSpacing="0">
                <Columns>
                    <asp:BoundField DataField="ScaleName" HeaderText="Scale" ItemStyle-VerticalAlign="Top"
                        ItemStyle-CssClass="app_small" HeaderStyle-CssClass="app_small" />
                    <asp:BoundField DataField="Score" HeaderText="%" ItemStyle-VerticalAlign="Top" ItemStyle-CssClass="app_small"
                        ItemStyle-HorizontalAlign="Right" HeaderStyle-CssClass="app_small" />
                    <asp:BoundField DataField="ScaleDesc" HeaderText="Scale Interpretations" ItemStyle-VerticalAlign="Top"
                        ItemStyle-CssClass="app_small" HeaderStyle-CssClass="app_small" />
                </Columns>
            </asp:GridView>
        </div>
        <!-- chart page -->
        <p class="newpage">
            &nbsp;
        </p>
        <uc:ph runat="server" ID="ph8" />
        <uc:phtitle runat="server" ID="phtitle8" pColorName="Cyan" />
        <asp:Label runat="server" ID="hpi_appendix" Visible="false"></asp:Label>
        <div style="padding-left: 90px; padding-right: 50px;">
            <asp:GridView runat="server" ID="tabChart" ShowHeader="True" ShowFooter="True" CellPadding="0"
                HeaderStyle-CssClass="charthead" CellSpacing="0" DataSourceID="rsCanText" AutoGenerateColumns="False"
                Width="570">
                <Columns>
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="200">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="ScaleScore" Text='<%# Eval("ScaleName") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="score" HeaderText="Score" ItemStyle-HorizontalAlign="Right" />
                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" ItemStyle-Width="372">
                        <ItemTemplate>
                            <%--<img alt="" runat="server" id="bar1" />--%>
                            <div runat="server" id="div1" style="position: relative; top: 0px; height: 26px;">
                            </div>
                        </ItemTemplate>
                        <FooterTemplate>
                            <table width="372" border="0" bordercolor="red" cellspacing="0" cellpadding="0">
                                <tr>
                                    <td align="center" width="134">
                                        low
                                    </td>
                                    <td align="center" width="104">
                                        average
                                    </td>
                                    <td align="center" width="133">
                                        high
                                    </td>
                                </tr>
                            </table>
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <br />
            <asp:Label runat="server" ID="chart_note" CssClass="notes"></asp:Label>
            <br />
            <br />
        </div>
        <%--        <div style="padding-left: 90px;">
            <asp:GridView runat="server" ID="tabScales" AutoGenerateColumns="false" CellSpacing="5"
                ShowHeader="false" GridLines="None" DataSourceID="rsCanText">
                <Columns>
                    <asp:TemplateField ItemStyle-VerticalAlign="Top">
                        <ItemTemplate>
                            <asp:Label runat="server" ID="Scalename" Text='<%# Eval("ScaleName") %>' CssClass="h4"></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Label runat="server" ID="ScaleDesc" Text='<%# Eval("ScaleDesc") %>'></asp:Label><br />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>--%>
        <!-- Appendix page 3-->
        <p class="newpage">
            &nbsp;
        </p>
        <uc:ph runat="server" ID="ph9" />
        <uc:phtitle runat="server" ID="phtitle9" pColorName="Cyan" />
        <asp:Label runat="server" ID="hpi_appendix2" Visible="false"></asp:Label>
        <div style="padding-left: 90px; padding-right: 50px;">
            <asp:Label runat="server" ID="Label1" Font-Bold="true" Text="Subscale Scores"></asp:Label><br />
            <hr />
            <asp:DataList runat="server" ID="tab2" DataSourceID="rsCanText" ItemStyle-Width="200"
                 RepeatColumns="3" RepeatDirection="Vertical"
                ItemStyle-VerticalAlign="top" CellPadding="5" >
                <ItemTemplate>
                     <table  width="100%">
                        <tr>
                            <td style="border-right: 1px dashed #CCCCCC; padding-right: 2px;">
                                
                                    <asp:Label runat="server" ID="ScaleName" Text='<%# Eval("ScaleName") %>' CssClass="bold_title"></asp:Label>
                                    <br />
                                    <br />
                                    <asp:GridView runat="server" ID="tabSubScales" GridLines="None" ShowHeader="false"
                                        AutoGenerateColumns="False" OnRowDataBound="hpi_bars">
                                        <Columns>
                                           
                                            <asp:BoundField DataField="SubscaleName" ItemStyle-Width="180" ItemStyle-HorizontalAlign="Right"  />
                                           


                                             <asp:TemplateField>
                                                <HeaderStyle CssClass="greytext" HorizontalAlign="Right" VerticalAlign="Bottom" />
                                                <ItemTemplate>
                                   
                                                    <table visible="true" border="0" style="table-layout:fixed; width: 80px;" cellspacing="0" cellpadding="0" runat="server"
                                                        id="hpibricks">
                                                        <tr style="height:20px;">
                                                            <td width="20" valign="middle" >

                                                                <!-- <img src="../images/hpi_bar.JPG" height=12  style="display:none" /> -->
                                                
                                                            </td>
                                                            <td valign="middle" width="20">
                                                                <!-- <img src="../images/hpi_bar.JPG" height=12  style="display:none" /> -->
                                                
                                                            </td>
                                                            <td valign="middle" width="20">
                                                                <!-- <img src="../images/hpi_bar.JPG" height=12  style="display:none" /> -->
                                                
                                                            </td>
                                                            <td valign="middle" width="20">
                                                                <!-- <img src="../images/hpi_bar.JPG" height=12  style="display:none" /> -->
                                              
                                                            </td>
                                                        </tr>
                                                    </table>
                                               
                                                </ItemTemplate>
                                            </asp:TemplateField>

                                        </Columns>
                                    </asp:GridView>
                                    <br />
                               
                            </td>
                        </tr>
                    </table>
                 </ItemTemplate>
            </asp:DataList></div>
        <!-- Appendix page 4 new HDS page 2015-10-03-->
        <p class="newpage">
            &nbsp;
        </p>
        <uc:ph runat="server" ID="ph11" />
        <uc:phtitle runat="server" ID="phtitle11" pColorName="Cyan" />
        <asp:Label runat="server" ID="notused" Visible="false"></asp:Label>
        <div style="padding-left: 90px; padding-right: 50px;">
            <asp:Label runat="server" ID="hds_subscalescores" Font-Bold="true" Text="Subscale Scores"></asp:Label><br />
            <hr />
            <asp:DataList CellSpacing="5" RepeatColumns="3" RepeatDirection="Horizontal" runat="server"
                BorderColor="White" BorderWidth="0" ID="tabHDSOuter" Width=680>
                <ItemTemplate>
                    <table border="0" width="100%">
                        <tr>
                            <td style="border-right: 1px dashed #CCCCCC; padding-right: 2px;">
                                <asp:Label runat="server" Visible="false" ID="ScaleID" Text='<%# Container.DataItem %>'></asp:Label>
                                <asp:SqlDataSource runat="server" ID="rsHDS" ConnectionString="<%$ ConnectionStrings:cMain %>"
                                    SelectCommand="SELECT CandidateID, ScaleName, subScaleName, score FROM qryCandidateData_HDS WHERE (CandidateID = @CandidateID) and ScaleID=@ScaleID ORDER BY subScaleID">
                                    <SelectParameters>
                                        <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" Type="Int32" />
                                        <asp:ControlParameter ControlID="ScaleID" DefaultValue="4" Name="ScaleID" PropertyName="Text" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:GridView runat="server" ID="tabHDS" CellPadding="0" CellSpacing="0" DataSourceID="rsHDS"
                                    ShowHeader="true" AutoGenerateColumns="false" OnRowDataBound="BindIt" BorderWidth="0"
                                    BorderStyle="None" GridLines="None">
                                    <Columns>
                                        <asp:BoundField DataField="SubScaleName" ItemStyle-Width="180" ItemStyle-HorizontalAlign="Right" />
                                        <asp:TemplateField>
                                            <HeaderStyle CssClass="greytext" HorizontalAlign="Right" VerticalAlign="Bottom" />
                                            <ItemTemplate>
                                                <table visible="true" border="0" style="table-layout:fixed; width: 80px;" cellspacing="0" cellpadding="0" runat="server"
                                                    id="tabscore">
                                                    <tr style="height:20px;">
                                                       <td width="20" valign="middle" >
                                                            <!-- <img src="../images/hds_bar.JPG" height=12   style="display:none"/> -->
                                                        </td>
                                                        <td valign="middle" width="20">
                                                            <!-- <img src="../images/hds_bar.JPG" height=12   style="display:none"/> -->
                                                        </td>
                                                        <td valign="middle" width="20">
                                                            <!-- <img src="../images/hds_bar.JPG" height=12   style="display:none"/> -->
                                                        </td>
                                                        <td valign="middle" width="20">
                                                            <!-- <img src="../images/hds_bar.JPG" height=12   style="display:none"/> -->
                                                        </td>
                                                    </tr>
                                                </table>
                                               
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                    <br /><br />
                </ItemTemplate>
            </asp:DataList>
        </div>
    </asp:Panel>
</asp:Content>
