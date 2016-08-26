<%@ Page Title="Candidate Scores" Trace="false" Debug="false" Language="VB" MasterPageFile="~/admin.master"
    AutoEventWireup="false" StylesheetTheme="Admin" CodeFile="CandidateScores.aspx.vb"
    Inherits="CandidateScores" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:SqlDataSource ID="rsC" runat="server" ConnectionString="<%$ ConnectionStrings:cMain %>"
        SelectCommand="SELECT [CandidateID], [FirstName], [LastName], Valid, [HPI1], [HPI2], [HPI3], [HPI4], [HPI5], [HPI6], [HPI7], [HDS1], [HDS2], [HDS3], [HDS4], [HDS5], [HDS6], [HDS7], [HDS8], [HDS9], [HDS10], [HDS11], [MVPI1], [MVPI2], [MVPI3], [MVPI4], [MVPI5], [MVPI6], [MVPI7], [MVPI8], [MVPI9], [MVPI10], [LF1], [LF2], [LF3], [LF4], [LF5], [HPIs2], [HPIs3], [HPIs4], [HPIs5], [HPIs6], [HPIs7], [HPIs8], [HPIs9], [HPIs10], [HPIs11], [HPIs12], [HPIs13], [HPIs14], [HPIs15], [HPIs16], [HPIs17], [HPIs18], [HPIs19], HPIs20, [HPIs21], [HPIs22], [HPIs23], [HPIs24], [HPIs25], [HPIs26], [HPIs27], [HPIs28], [HPIs29], HPIs30, [HPIs31], [HPIs32], [HPIs33], [HPIs34], [HPIs35], [HPIs36], [HPIs37], [HPIs38], [HPIs39], HPIs40, HPIs41, HPIs42 FROM [Candidates] WHERE ([CandidateID] = @CandidateID)"
        UpdateCommand="UPDATE [Candidates] SET [FirstName] = @FirstName, [LastName] = @LastName, Valid=@Valid, [HPI1] = @HPI1, [HPI2] = @HPI2, [HPI3] = @HPI3, [HPI4] = @HPI4, [HPI5] = @HPI5, [HPI6] = @HPI6, [HPI7] = @HPI7, [HDS1] = @HDS1, [HDS2] = @HDS2, [HDS3] = @HDS3, [HDS4] = @HDS4, [HDS5] = @HDS5, [HDS6] = @HDS6, [HDS7] = @HDS7, [HDS8] = @HDS8, [HDS9] = @HDS9, [HDS10] = @HDS10, [HDS11] = @HDS11, [MVPI1] = @MVPI1, [MVPI2] = @MVPI2, [MVPI3] = @MVPI3, [MVPI4] = @MVPI4, [MVPI5] = @MVPI5, [MVPI6] = @MVPI6, [MVPI7] = @MVPI7, [MVPI8] = @MVPI8, [MVPI9] = @MVPI9, [MVPI10] = @MVPI10, [LF1] = @LF1, [LF2] = @LF2, [LF3] = @LF3, [LF4] = @LF4, [LF5] = @LF5, [HPIs2] = @HPIs2, [HPIs3] = @HPIs3, [HPIs4] = @HPIs4, [HPIs5] = @HPIs5, [HPIs6] = @HPIs6, [HPIs7] = @HPIs7, HPIs8=@HPIs8, HPIs9=@HPIs9, HPIs10=@HPIs10, HPIs11=@HPIs11, [HPIs12] = @HPIs12, [HPIs13] = @HPIs13, [HPIs14] = @HPIs14, [HPIs15] = @HPIs15, [HPIs16] = @HPIs16, [HPIs17] = @HPIs17, HPIs18=@HPIs18, HPIs19=@HPIs19, HPIs20=@HPIs20, HPIs21=@HPIs21, [HPIs22] = @HPIs22, [HPIs23] = @HPIs23, [HPIs24] = @HPIs24, [HPIs25] = @HPIs25, [HPIs26] = @HPIs26, [HPIs27] = @HPIs27, HPIs28=@HPIs28, HPIs29=@HPIs29, HPIs30=@HPIs30, HPIs31=@HPIs31, [HPIs32] = @HPIs32, [HPIs33] = @HPIs33, [HPIs34] = @HPIs34, [HPIs35] = @HPIs35, [HPIs36] = @HPIs36, [HPIs37] = @HPIs37, HPIs38=@HPIs38, HPIs39=@HPIs39, HPIs40=@HPIs40, HPIs41=@HPIs41, HPIs42=@HPIs42 WHERE [CandidateID] = @CandidateID">
        <SelectParameters>
            <asp:QueryStringParameter Name="CandidateID" QueryStringField="CandidateID" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
            <asp:Parameter Name="Valid" Type="Byte" />
            <asp:Parameter Name="HPI1" Type="Byte" />
            <asp:Parameter Name="HPI2" Type="Byte" />
            <asp:Parameter Name="HPI3" Type="Byte" />
            <asp:Parameter Name="HPI4" Type="Byte" />
            <asp:Parameter Name="HPI5" Type="Byte" />
            <asp:Parameter Name="HPI6" Type="Byte" />
            <asp:Parameter Name="HPI7" Type="Byte" />
            <asp:Parameter Name="HDS1" Type="Byte" />
            <asp:Parameter Name="HDS2" Type="Byte" />
            <asp:Parameter Name="HDS3" Type="Byte" />
            <asp:Parameter Name="HDS4" Type="Byte" />
            <asp:Parameter Name="HDS5" Type="Byte" />
            <asp:Parameter Name="HDS6" Type="Byte" />
            <asp:Parameter Name="HDS7" Type="Byte" />
            <asp:Parameter Name="HDS8" Type="Byte" />
            <asp:Parameter Name="HDS9" Type="Byte" />
            <asp:Parameter Name="HDS10" Type="Byte" />
            <asp:Parameter Name="HDS11" Type="Byte" />
            <asp:Parameter Name="MVPI1" Type="Byte" />
            <asp:Parameter Name="MVPI2" Type="Byte" />
            <asp:Parameter Name="MVPI3" Type="Byte" />
            <asp:Parameter Name="MVPI4" Type="Byte" />
            <asp:Parameter Name="MVPI5" Type="Byte" />
            <asp:Parameter Name="MVPI6" Type="Byte" />
            <asp:Parameter Name="MVPI7" Type="Byte" />
            <asp:Parameter Name="MVPI8" Type="Byte" />
            <asp:Parameter Name="MVPI9" Type="Byte" />
            <asp:Parameter Name="MVPI10" Type="Byte" />
            <asp:Parameter Name="LF1" Type="Int32" />
            <asp:Parameter Name="LF2" Type="Int32" />
            <asp:Parameter Name="LF3" Type="Int32" />
            <asp:Parameter Name="LF4" Type="Int32" />
            <asp:Parameter Name="LF5" Type="Int32" />
            <asp:Parameter Name="HPIs2" Type="Byte" />
            <asp:Parameter Name="HPIs3" Type="Byte" />
            <asp:Parameter Name="HPIs4" Type="Byte" />
            <asp:Parameter Name="HPIs5" Type="Byte" />
            <asp:Parameter Name="HPIs6" Type="Byte" />
            <asp:Parameter Name="HPIs7" Type="Byte" />
            <asp:Parameter Name="HPIs8" Type="Byte" />
            <asp:Parameter Name="HPIs9" Type="Byte" />
            <asp:Parameter Name="HPIs10" Type="Byte" />
            <asp:Parameter Name="HPIs11" Type="Byte" />
            <asp:Parameter Name="HPIs12" Type="Byte" />
            <asp:Parameter Name="HPIs13" Type="Byte" />
            <asp:Parameter Name="HPIs14" Type="Byte" />
            <asp:Parameter Name="HPIs15" Type="Byte" />
            <asp:Parameter Name="HPIs16" Type="Byte" />
            <asp:Parameter Name="HPIs17" Type="Byte" />
            <asp:Parameter Name="HPIs18" Type="Byte" />
            <asp:Parameter Name="HPIs19" Type="Byte" />
            <asp:Parameter Name="HPIs20" Type="Byte" />
            <asp:Parameter Name="HPIs21" Type="Byte" />
            <asp:Parameter Name="HPIs22" Type="Byte" />
            <asp:Parameter Name="HPIs23" Type="Byte" />
            <asp:Parameter Name="HPIs24" Type="Byte" />
            <asp:Parameter Name="HPIs25" Type="Byte" />
            <asp:Parameter Name="HPIs26" Type="Byte" />
            <asp:Parameter Name="HPIs27" Type="Byte" />
            <asp:Parameter Name="HPIs28" Type="Byte" />
            <asp:Parameter Name="HPIs29" Type="Byte" />
            <asp:Parameter Name="HPIs30" Type="Byte" />
            <asp:Parameter Name="HPIs31" Type="Byte" />
            <asp:Parameter Name="HPIs32" Type="Byte" />
            <asp:Parameter Name="HPIs33" Type="Byte" />
            <asp:Parameter Name="HPIs34" Type="Byte" />
            <asp:Parameter Name="HPIs35" Type="Byte" />
            <asp:Parameter Name="HPIs36" Type="Byte" />
            <asp:Parameter Name="HPIs37" Type="Byte" />
            <asp:Parameter Name="HPIs38" Type="Byte" />
            <asp:Parameter Name="HPIs39" Type="Byte" />
            <asp:Parameter Name="HPIs40" Type="Byte" />
            <asp:Parameter Name="HPIs41" Type="Byte" />
            <asp:Parameter Name="HPIs42" Type="Byte" />
            <asp:Parameter Name="CandidateID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
    <asp:FormView ID="frmC" runat="server" DataKeyNames="CandidateID" DefaultMode="Edit"
        BorderStyle="Solid" BorderColor="Black" DataSourceID="rsC" EnableModelValidation="True">
        <EditItemTemplate>
            <table cellspacing="0" cellpadding="3" border="1">
                <tr>
                    <td>
                        <b>CandidateID:</b><br />
                        <asp:Label ID="CandidateIDLabel1" runat="server" Text='<%# Eval("CandidateID") %>' />
                    </td>
                    <td>
                        <b>FirstName:</b><br />
                        <asp:TextBox ID="FirstName" runat="server" Text='<%# Bind("FirstName") %>' />
                    </td>
                    <td>
                        <b>LastName:</b><br />
                        <asp:TextBox ID="LastName" runat="server" Text='<%# Bind("LastName") %>' />
                    </td>
                    <td>
                        <b>Valid:</b><br />
                        <asp:TextBox ID="Valid" Width="30" runat="server" Text='<%# Bind("Valid") %>' />
                    </td>
                    <td>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>HPI</b>
                    </td>
                    <td>
                        <b>HDS</b>
                    </td>
                    <td>
                        <b>MVPI</b>
                    </td>
                    <td>
                        <b>LeaderFit</b>
                    </td>
                    <td align="center">
                        <b>HPIs</b>
                    </td>
                </tr>
                <tr>
                    <td valign="top">
                        ADJU:
                        <asp:TextBox ID="HPI1" Width="30" runat="server" ToolTip="Adjustment" Text='<%# Bind("HPI1") %>' />
                        <br />
                        AMBI:
                        <asp:TextBox ID="HPI2" Width="30" runat="server" ToolTip="Ambition" Text='<%# Bind("HPI2") %>' />
                        <br />
                        SOCI:
                        <asp:TextBox ID="HPI3" Width="30" runat="server" ToolTip="Sociability" Text='<%# Bind("HPI3") %>' />
                        <br />
                        INTS:
                        <asp:TextBox ID="HPI4" Width="30" runat="server" ToolTip="Interpersonal Sensitivity" Text='<%# Bind("HPI4") %>' />
                        <br />
                        PRUD:
                        <asp:TextBox ID="HPI5" Width="30" runat="server" ToolTip="Prudence" Text='<%# Bind("HPI5") %>' />
                        <br />
                        INQU:
                        <asp:TextBox ID="HPI6" Width="30" runat="server" ToolTip="Inquisitive" Text='<%# Bind("HPI6") %>' />
                        <br />
                        LRNA:
                        <asp:TextBox ID="HPI7" Width="30" runat="server" ToolTip="Learning Approach" Text='<%# Bind("HPI7") %>' />
                    </td>
                    <td valign="top">
                        EXCI:
                        <asp:TextBox ID="HDS1" Width="30" runat="server" ToolTip="Excitable"  Text='<%# Bind("HDS1") %>' />
                        <br />
                        SKEP:
                        <asp:TextBox ID="HDS2" Width="30" runat="server" ToolTip="Skeptical" Text='<%# Bind("HDS2") %>' />
                        <br />
                        CAUT:
                        <asp:TextBox ID="HDS3" Width="30" runat="server" ToolTip="Cautious" Text='<%# Bind("HDS3") %>' />
                        <br />
                        RESE:
                        <asp:TextBox ID="HDS4" Width="30" runat="server" ToolTip="Reserved" Text='<%# Bind("HDS4") %>' />
                        <br />
                        LEIS:
                        <asp:TextBox ID="HDS5" Width="30" runat="server" ToolTip="Leisurely"  Text='<%# Bind("HDS5") %>' />
                        <br />
                        BOLD:
                        <asp:TextBox ID="HDS6" Width="30" runat="server" ToolTip="Bold"  Text='<%# Bind("HDS6") %>' />
                        <br />
                        MISC:
                        <asp:TextBox ID="HDS7" Width="30" runat="server" ToolTip="Mischievous" Text='<%# Bind("HDS7") %>' />
                        <br />
                        COLO:
                        <asp:TextBox ID="HDS8" Width="30" runat="server" ToolTip="Colorful" Text='<%# Bind("HDS8") %>' />
                        <br />
                        IMAG:
                        <asp:TextBox ID="HDS9" Width="30" runat="server" ToolTip="Imaginative" Text='<%# Bind("HDS9") %>' />
                        <br />
                        DILI:
                        <asp:TextBox ID="HDS10" Width="30" runat="server" ToolTip="Diligent" Text='<%# Bind("HDS10") %>' />
                        <br />
                        DUTI:
                        <asp:TextBox ID="HDS11" Width="30" runat="server" ToolTip="Dutiful" Text='<%# Bind("HDS11") %>' />
                    </td>
                    <td valign="top">
                        RECO:
                        <asp:TextBox ID="MVPI1" Width="30" runat="server" ToolTip="Recognition" Text='<%# Bind("MVPI1") %>' />
                        <br />
                        POWE:
                        <asp:TextBox ID="MVPI2" Width="30" runat="server" ToolTip="Power" Text='<%# Bind("MVPI2") %>' />
                        <br />
                        HEDO:
                        <asp:TextBox ID="MVPI3" Width="30" runat="server" ToolTip="Hedonism" Text='<%# Bind("MVPI3") %>' />
                        <br />
                        ALTR:
                        <asp:TextBox ID="MVPI4" Width="30" runat="server" ToolTip="Altruistic" Text='<%# Bind("MVPI4") %>' />
                        <br />
                        AFFI:
                        <asp:TextBox ID="MVPI5" Width="30" runat="server" ToolTip="Affiliation" Text='<%# Bind("MVPI5") %>' />
                        <br />
                        TRAD:
                        <asp:TextBox ID="MVPI6" Width="30" runat="server" ToolTip="Tradition" Text='<%# Bind("MVPI6") %>' />
                        <br />
                        SECU:
                        <asp:TextBox ID="MVPI7" Width="30" runat="server" ToolTip="Security" Text='<%# Bind("MVPI7") %>' />
                        <br />
                        COMM:
                        <asp:TextBox ID="MVPI8" Width="30" runat="server" ToolTip="Commerce" Text='<%# Bind("MVPI8") %>' />
                        <br />
                        AEST:
                        <asp:TextBox ID="MVPI9" Width="30" runat="server" ToolTip="Aesthetics" Text='<%# Bind("MVPI9") %>' />
                        <br />
                        SCIE:
                        <asp:TextBox ID="MVPI10" Width="30" runat="server" ToolTip="Science" Text='<%# Bind("MVPI10") %>' />
                    </td>
                    <td valign="top">
                        Strat. Clarity:
                        <asp:TextBox ID="LF1" Width="30" runat="server" Text='<%# Bind("LF1") %>' />
                        <br />
                        Exec. Savvy:
                        <asp:TextBox ID="LF2" Width="30" runat="server" Text='<%# Bind("LF2") %>' />
                        <br />
                        Res. and Adapt.:
                        <asp:TextBox ID="LF3" Width="30" runat="server" Text='<%# Bind("LF3") %>' />
                        <br />
                        Stakeholder Mgmt:
                        <asp:TextBox ID="LF4" Width="30" runat="server" Text='<%# Bind("LF4") %>' />
                        <br />
                        Ppl and Team Dev.:
                        <asp:TextBox ID="LF5" Width="30" runat="server" Text='<%# Bind("LF5") %>' />
                    </td>
                    <td valign="top">
                        <table cellpadding="2" cellspacing="0" style="border: 1px solid maroon;">
                            <tr>
                                <td valign="top" align="right">
                                    HPIs1:
                                    <asp:TextBox ID="spacer" Width="30" runat="server" Text="NA" Enabled="false" />
                                    <br />
                                    HPIs2:
                                    <asp:TextBox ID="HPIs2" Width="30" runat="server" Text='<%# Bind("HPIs2") %>' />
                                    <br />
                                    HPIs3:
                                    <asp:TextBox ID="HPIs3" Width="30" runat="server" Text='<%# Bind("HPIs3") %>' />
                                    <br />
                                    HPIs4:
                                    <asp:TextBox ID="HPIs4" Width="30" runat="server" Text='<%# Bind("HPIs4") %>' />
                                    <br />
                                    HPIs5:
                                    <asp:TextBox ID="HPIs5" Width="30" runat="server" Text='<%# Bind("HPIs5") %>' />
                                    <br />
                                    HPIs6:
                                    <asp:TextBox ID="HPIs6" Width="30" runat="server" Text='<%# Bind("HPIs6") %>' />
                                    <br />
                                    HPIs7:
                                    <asp:TextBox ID="HPIs7" Width="30" runat="server" Text='<%# Bind("HPIs7") %>' />
                                    <br />
                                    HPIs8:
                                    <asp:TextBox ID="HPIs8" Width="30" runat="server" Text='<%# Bind("HPIs8") %>' />
                                    <br />
                                    HPIs9:
                                    <asp:TextBox ID="HPIs9" Width="30" runat="server" Text='<%# Bind("HPIs9") %>' />
                                    <br />
                                    HPIs10:
                                    <asp:TextBox ID="HPIs10" Width="30" runat="server" Text='<%# Bind("HPIs10") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs11:
                                    <asp:TextBox ID="HPIs11" Width="30" runat="server" Text='<%# Bind("HPIs11") %>' />
                                    <br />
                                    HPIs12:
                                    <asp:TextBox ID="HPIs12" Width="30" runat="server" Text='<%# Bind("HPIs12") %>' />
                                    <br />
                                    HPIs13:
                                    <asp:TextBox ID="HPIs13" Width="30" runat="server" Text='<%# Bind("HPIs13") %>' />
                                    <br />
                                    HPIs14:
                                    <asp:TextBox ID="HPIs14" Width="30" runat="server" Text='<%# Bind("HPIs14") %>' />
                                    <br />
                                    HPIs15:
                                    <asp:TextBox ID="HPIs15" Width="30" runat="server" Text='<%# Bind("HPIs15") %>' />
                                    <br />
                                    HPIs16:
                                    <asp:TextBox ID="HPIs16" Width="30" runat="server" Text='<%# Bind("HPIs16") %>' />
                                    <br />
                                    HPIs17:
                                    <asp:TextBox ID="HPIs17" Width="30" runat="server" Text='<%# Bind("HPIs17") %>' />
                                    <br />
                                    HPIs18:
                                    <asp:TextBox ID="HPIs18" Width="30" runat="server" Text='<%# Bind("HPIs18") %>' />
                                    <br />
                                    HPIs19:
                                    <asp:TextBox ID="HPIs19" Width="30" runat="server" Text='<%# Bind("HPIs19") %>' />
                                    <br />
                                    HPIs20:
                                    <asp:TextBox ID="HPIs20" Width="30" runat="server" Text='<%# Bind("HPIs20") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs21:
                                    <asp:TextBox ID="HPIs21" Width="30" runat="server" Text='<%# Bind("HPIs21") %>' />
                                    <br />
                                    HPIs22:
                                    <asp:TextBox ID="HPIs22" Width="30" runat="server" Text='<%# Bind("HPIs22") %>' />
                                    <br />
                                    HPIs23:
                                    <asp:TextBox ID="HPIs23" Width="30" runat="server" Text='<%# Bind("HPIs23") %>' />
                                    <br />
                                    HPIs24:
                                    <asp:TextBox ID="HPIs24" Width="30" runat="server" Text='<%# Bind("HPIs24") %>' />
                                    <br />
                                    HPIs25:
                                    <asp:TextBox ID="HPIs25" Width="30" runat="server" Text='<%# Bind("HPIs25") %>' />
                                    <br />
                                    HPIs26:
                                    <asp:TextBox ID="HPIs26" Width="30" runat="server" Text='<%# Bind("HPIs26") %>' />
                                    <br />
                                    HPIs27:
                                    <asp:TextBox ID="HPIs27" Width="30" runat="server" Text='<%# Bind("HPIs27") %>' />
                                    <br />
                                    HPIs28:
                                    <asp:TextBox ID="HPIs28" Width="30" runat="server" Text='<%# Bind("HPIs28") %>' />
                                    <br />
                                    HPIs29:
                                    <asp:TextBox ID="HPIs29" Width="30" runat="server" Text='<%# Bind("HPIs29") %>' />
                                    <br />
                                    HPIs30:
                                    <asp:TextBox ID="HPIs30" Width="30" runat="server" Text='<%# Bind("HPIs30") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs31:
                                    <asp:TextBox ID="HPIs31" Width="30" runat="server" Text='<%# Bind("HPIs31") %>' />
                                    <br />
                                    HPIs32:
                                    <asp:TextBox ID="HPIs32" Width="30" runat="server" Text='<%# Bind("HPIs32") %>' />
                                    <br />
                                    HPIs33:
                                    <asp:TextBox ID="HPIs33" Width="30" runat="server" Text='<%# Bind("HPIs33") %>' />
                                    <br />
                                    HPIs34:
                                    <asp:TextBox ID="HPIs34" Width="30" runat="server" Text='<%# Bind("HPIs34") %>' />
                                    <br />
                                    HPIs35:
                                    <asp:TextBox ID="HPIs35" Width="30" runat="server" Text='<%# Bind("HPIs35") %>' />
                                    <br />
                                    HPIs36:
                                    <asp:TextBox ID="HPIs36" Width="30" runat="server" Text='<%# Bind("HPIs36") %>' />
                                    <br />
                                    HPIs37:
                                    <asp:TextBox ID="HPIs37" Width="30" runat="server" Text='<%# Bind("HPIs37") %>' />
                                    <br />
                                    HPIs38:
                                    <asp:TextBox ID="HPIs38" Width="30" runat="server" Text='<%# Bind("HPIs38") %>' />
                                    <br />
                                    HPIs39:
                                    <asp:TextBox ID="HPIs39" Width="30" runat="server" Text='<%# Bind("HPIs39") %>' />
                                    <br />
                                    HPIs40:
                                    <asp:TextBox ID="HPIs40" Width="30" runat="server" Text='<%# Bind("HPIs40") %>' />
                                </td>
                                <td valign="top" align="right">
                                    HPIs41:
                                    <asp:TextBox ID="HPIs41" Width="30" runat="server" Text='<%# Bind("HPIs41") %>' />
                                    <br />
                                    HPIs42:
                                    <asp:TextBox ID="HPIs42" Width="30" runat="server" Text='<%# Bind("HPIs42") %>' />
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <br />
            <center>
                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="Update" />
                &nbsp;<asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False"
                    CommandName="Cancel" Text="Cancel" />
                &nbsp;<asp:Button ID="btnCalc" runat="server" CausesValidation="False" CommandName="Calc"
                    Text="Calculate" /></center>
        </EditItemTemplate>
    </asp:FormView>
</asp:Content>
