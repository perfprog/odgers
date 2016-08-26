<%@ Page Language="VB" Trace="False" Debug="true" EnableViewState="False" MasterPageFile="Leaderfit.master"
    AutoEventWireup="false" StylesheetTheme="creative" CodeFile="Report_Appendix_HDS.aspx.vb"
    Inherits="CustomRpt_Report_HDS" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel runat="server" ID="pMain" Width="800">
        <!-- HDS -->
        <asp:DataList CellSpacing="5" RepeatColumns="3" RepeatDirection="Horizontal" runat="server"
            ID="tabHDSOuter">
            <ItemTemplate>
                <table border="0">
                    <tr>
                        <td style="border-right:1px dashed #CCCCCC; padding-right:15px;">
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
                                BorderColor="White">
                                <Columns>
                                    <asp:BoundField DataField="SubScaleName" ItemStyle-Width="120" ItemStyle-HorizontalAlign="Right" />
                                    <asp:TemplateField>
                                        <HeaderStyle CssClass="greytext" HorizontalAlign="Right" VerticalAlign="Bottom" />
                                        <ItemTemplate>
                                            <table border="0" width="100%" cellspacing="0" cellpadding="2" runat="server" id="tabscore">
                                                <tr>
                                                    <td width="20" valign="middle">
                                                        <img src="../images/hpi_bar.JPG" height=15 />
                                                    </td>
                                                    <td valign="middle" width="20">
                                                        <img src="../images/hpi_bar.JPG" height=15  />
                                                    </td>
                                                    <td valign="middle" width="20">
                                                        <img src="../images/hpi_bar.JPG" height=15  />
                                                    </td>
                                                    <td valign="middle" width="20">
                                                        <img src="../images/hpi_bar.JPG" height=15  />
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
            </ItemTemplate>
        </asp:DataList>
    </asp:Panel>
</asp:Content>
