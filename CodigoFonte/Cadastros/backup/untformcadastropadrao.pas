unit untFormCadastroPadrao;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  ActnList, ExtCtrls, StdCtrls, Buttons, DBCtrls, ExtendedTabControls,
  DividerBevel, rxtoolbar, rxpagemngr, BCPanel, BCRoundedImage,
  BGRAImageManipulation, BCToolBar, BGRAImageList, BCListBox, BCLabel,
  BGRAImageTheme, BGRAColorTheme, BGRASVGImageList, BGRACustomDrawn, sqldb,
  BCImageButton, BGRASpeedButton, BGRAThemeRadioButton, ATFlatToolbar, ATGauge;

type
  TExecutar = (Navegacao, SentencaSQL, ExibePanels, DesabilitaBotoes,
               HabilitaBotoes);

  { TFormCadastroPadrao }

  TFormCadastroPadrao = class(TForm)
    actFiltrar: TAction;
    actAnterior: TAction;
    actAdicionar: TAction;
    actEditar: TAction;
    actExcluir: TAction;
    actCancelar: TAction;
    actSair: TAction;
    actSalvar: TAction;
    actMarcar: TAction;
    actUltimo: TAction;
    actProximo: TAction;
    actPrimeiro: TAction;
    actOrdenar: TAction;
    ActionList1: TActionList;
    ATGauge1: TATGauge;
    BCLabel1: TBCLabel;
    BCPanel1: TBCPanel;
    BCPanel2: TBCPanel;
    BCPanel3: TBCPanel;
    BCRoundedImage1: TBCRoundedImage;
    BCToolBar1: TBCToolBar;
    BGRAImageList1: TBGRAImageList;
    imagesHab: TBGRAImageList;
    BGRASpeedButton1: TBGRASpeedButton;
    BGRAThemeRadioButton1: TBGRAThemeRadioButton;
    BGRAThemeRadioButton2: TBGRAThemeRadioButton;
    BGRAThemeRadioButton3: TBGRAThemeRadioButton;
    dsPadrao: TDataSource;
    edtPesquisa: TEdit;
    Image1: TImage;
    mnFiltrarTodos: TMenuItem;
    MenuItem2: TMenuItem;
    mnFiltrarMarcados: TMenuItem;
    mnFiltrarBloqueados: TMenuItem;
    mnFiltrarCodigo: TMenuItem;
    Separator1: TMenuItem;
    pcPadrao: TPageControl;
    pnTitulo: TBCPanel;
    btnFiltro: TToolButton;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    PopupMenu3: TPopupMenu;
    PopupMenu4: TPopupMenu;
    btnOrdenar: TToolButton;
    btnAnterior: TToolButton;
    btnProximo: TToolButton;
    btnUltimo: TToolButton;
    ProgressBar1: TProgressBar;
    StatusBar1: TStatusBar;
    tabFormulario: TTabSheet;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    btnPrimeiro: TToolButton;
    btnIncluir: TToolButton;
    btnEditar: TToolButton;
    btnExcluir: TToolButton;
    ToolButton3: TToolButton;
    btnMarcar: TToolButton;
    ToolButton4: TToolButton;
    btnSalvar: TToolButton;
    btnCancelar: TToolButton;
    ToolButton5: TToolButton;
    btnFechar: TToolButton;
    procedure actAdicionarExecute(Sender: TObject);
    procedure actAnteriorExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure actEditarExecute(Sender: TObject);
    procedure actExcluirExecute(Sender: TObject);
    procedure actFiltrarExecute(Sender: TObject);
    procedure actMarcarExecute(Sender: TObject);
    procedure actOrdenarExecute(Sender: TObject);
    procedure actPrimeiroExecute(Sender: TObject);
    procedure actSairExecute(Sender: TObject);
    procedure actSalvarExecute(Sender: TObject);
    procedure actUltimoExecute(Sender: TObject);
    procedure BCRoundedImage1Click(Sender: TObject);
  private
        { Private declarations }
    sINC,
    sALT,
    sEXC: String;
    FExecutar: TExecutar;
    procedure SetExecutar(const Value: TExecutar);
  public
    blnMudarFoco: Boolean;
    property Executar: TExecutar read FExecutar write SetExecutar;
    procedure pLimpaCampos;
  end;

var
  FormCadastroPadrao: TFormCadastroPadrao;
  SQLQuery : TSQLQuery;
  sTipST,             { Tipo de ST (ICMS, IPI, PIS, COFINS) }
  sMensagem,          { Guarda Mensagens }
  sSQL,               { Guarda a instrução SQL }
  sTabela,            { Guarda o Nome da Tabela }
  sCampo,             { Guarda o Nome do Campo da Tabela para Pesquisa }
  sJanela: String;    { Nome da janela }
  iINC,               { Define uma Operação de Inclusão }
  iPES: Integer;      { Controle do botão Pesquisar da janela PesqData }

implementation
         uses untFuncoes;
{$R *.lfm}

{ TFormCadastroPadrao }

procedure TFormCadastroPadrao.BCRoundedImage1Click(Sender: TObject);
begin

end;

procedure TFormCadastroPadrao.SetExecutar(const Value: TExecutar);
begin
  FExecutar := Value;
  case Value of
    { Habilita botões de navegação }
    Navegacao:
    begin
      if dsPadrao.DataSet.Eof then
      begin
        btnProximo.Enabled := False;
        btnUltimo.Enabled  := False;
      end
      else
      begin
        btnProximo.Enabled := True;
        btnUltimo.Enabled  := True;
      end;
      if dsPadrao.DataSet.Bof then
      begin
        btnPrimeiro.Enabled := False;
        btnAnterior.Enabled := False;
      end
      else
      begin
        btnPrimeiro.Enabled := True;
        btnAnterior.Enabled := True;
      end;
    end;
    { Executa a sentença SQL }
    SentencaSQL:
    begin
      dsPadrao.DataSet.DisableControls;
      try
        dsPadrao.DataSet.Close;
         SQLQuery := TSQLQuery.Create(nil);
         SQLQuery.SQL.Text := sSQL;
         SQLQuery.Open;
        dsPadrao.DataSet := SQLQuery;
      finally
        dsPadrao.DataSet.EnableControls;
      end;
      dsPadrao.DataSet.First;
      if (dsPadrao.DataSet.RecordCount = 0) and (iINC = 0) then
      begin
        fMensagem('ATENÇÃO!', 'Não foi encontrado nenhum registro que ' + #13 +
                              'satisfaça a sua pesquisa!', ['&o K']);
      end;
    end;
    { Exibe os textos nos paineis da barra de status }
    ExibePanels:
    begin

    end;
    { Desabilita botões ao incluir ou alterar um registro }
    DesabilitaBotoes:
    begin
      btnFiltro.Enabled   := False;
      btnOrdenar.Enabled  := False;
      btnPrimeiro.Enabled := False;
      btnAnterior.Enabled := False;
      btnProximo.Enabled  := False;
      btnUltimo.Enabled   := False;
      btnIncluir.Enabled  := False;
      btnEditar.Enabled   := False;
      btnExcluir.Enabled  := False;
      btnMarcar.Enabled   := False;
      btnSalvar.Enabled   := True;
      btnCancelar.Enabled := True;
      btnFechar.Enabled   := False;
    end;
    { Habilita botões ao gravar ou cancelar uma inclusão ou alteração }
    HabilitaBotoes:
    begin
      btnFiltro.Enabled   := True;
      btnOrdenar.Enabled  := True;
      btnPrimeiro.Enabled := True;
      btnAnterior.Enabled := True;
      btnProximo.Enabled  := True;
      btnUltimo.Enabled   := True;
      btnIncluir.Enabled  := True;
      if (dsPadrao.DataSet.RecordCount > 0) then
        btnOrdenar.Enabled := True
      else
        btnOrdenar.Enabled := False;
      if (dsPadrao.DataSet.RecordCount = 0) then
      begin
        btnEditar.Enabled  := False;
        btnExcluir.Enabled := False;
        btnMarcar.Enabled  := False;
      end
      else
      begin
        btnEditar.Enabled  := True;
        btnExcluir.Enabled := True;
        btnMarcar.Enabled  := True;
      end;
      btnSalvar.Enabled   := False;
      btnCancelar.Enabled := False;
      btnFechar.Enabled   := True;
    end;
  end;
end;

procedure TFormCadastroPadrao.pLimpaCampos;
begin
  ;
end;

procedure TFormCadastroPadrao.actFiltrarExecute(Sender: TObject);
begin
   ;
end;

procedure TFormCadastroPadrao.actMarcarExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actAnteriorExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actCancelarExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actEditarExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actExcluirExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actAdicionarExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actOrdenarExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actPrimeiroExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actSairExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actSalvarExecute(Sender: TObject);
begin
  ;
end;

procedure TFormCadastroPadrao.actUltimoExecute(Sender: TObject);
begin
  ;
end;

end.

