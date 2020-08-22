unit frmCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.DBCtrls, Vcl.Mask;

type
  TFormCadProduto = class(TForm)
    lbl1: TLabel;
    shp2: TShape;
    img2: TImage;
    img1: TImage;
    shp1: TShape;
    grp1: TGroupBox;
    dbgrd1: TDBGrid;
    btnCancelar: TButton;
    btnSalvar: TButton;
    btnExcluir: TButton;
    btnAlterar: TButton;
    btnNovo: TButton;
    PesquisaProduto: TSearchBox;
    grp2: TGroupBox;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl9: TLabel;
    btnFechar: TButton;
    dsProduto: TDataSource;
    dbedtcodigo_produto: TDBEdit;
    dbmmodescricao: TDBMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure PesquisaProdutoChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCadProduto: TFormCadProduto;
  valorAlterado : string;

implementation

{$R *.dfm}

uses UdmCadProduto;

procedure TFormCadProduto.btnAlterarClick(Sender: TObject);
begin
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
  btnNovo.Enabled := False; 
  
  dbedtcodigo_produto.Enabled := True;
  dbmmodescricao.Enabled := True;

  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;

  try
    dmCadProduto.FDQueryProduto.Edit;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Alterar, Messagem de erro: ' + E.Message),
         'Erro ao Alterar',MB_ICONERROR+MB_OK);
  end; 
end;

procedure TFormCadProduto.btnCancelarClick(Sender: TObject);
begin
  dbedtcodigo_produto.Enabled := False;
  dbmmodescricao.Enabled := False;
  btnSalvar.Enabled := False;
  btnCancelar.Enabled := False;

  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;
  
  try
    dmCadProduto.FDQueryProduto.Cancel;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Cancelar, Messagem de erro: ' + E.Message),
         'Erro ao Cancelar',MB_ICONERROR+MB_OK);
  end; 
end;

procedure TFormCadProduto.btnExcluirClick(Sender: TObject);
begin  
  //btnExcluir.Enabled := False;
  try
    dmCadProduto.FDQueryProduto.Delete;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Excluir, Messagem de erro: ' + E.Message),
         'Erro ao Excluir',MB_ICONERROR+MB_OK);
  end;

  if dmCadProduto.FDQueryProduto.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;
end;

procedure TFormCadProduto.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFormCadProduto.btnNovoClick(Sender: TObject);
begin
  btnNovo.Enabled:= False;
  try
    dmCadProduto.FDQueryProduto.Append;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao criar um novo registro!, Messagem de erro:' + E.Message),        
       'Erro ao criar um novo registro!',MB_ICONERROR+MB_OK);                 
  end;
  
  btnExcluir.Enabled := False;
  btnAlterar.Enabled := False;

  dbedtcodigo_produto.Enabled := True;
  dbedtcodigo_produto.Text := '';

  dbmmodescricao.Enabled := True;
  dbmmodescricao.Lines.Text := '';
  
  btnSalvar.Enabled := True;
  btnCancelar.Enabled := True;    
end;

procedure TFormCadProduto.btnSalvarClick(Sender: TObject);
begin
  if string.Equals(Trim(dbedtcodigo_produto.Text), EmptyStr) or
     string.Equals(Trim(dbmmodescricao.Lines.Text), EmptyStr)
  then
  begin
    Application.MessageBox('Os Campos não podem estar vazios~',
      'Campos vazios~',MB_ICONERROR+MB_OK);
    Exit;
  end;
   

  try
    dmCadProduto.FDQueryProduto.Post;
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Salvar, Messagem de erro:' + E.Message),        
       'Erro ao Salvar',MB_ICONERROR+MB_OK);                 
  end;


  btnExcluir.Enabled := True;
  btnAlterar.Enabled := True;
  btnNovo.Enabled := True;

  dbedtcodigo_produto.Enabled := False;
  dbmmodescricao.Enabled := False;

  btnCancelar.Enabled := False;
  btnSalvar.Enabled := False;
end;

procedure TFormCadProduto.FormCreate(Sender: TObject);
begin  
  dmCadProduto.inicializaConsultaProduto;
  dsProduto.DataSet := dmCadProduto.FDQueryProduto;

  if dmCadProduto.FDQueryProduto.IsEmpty then
  begin
    btnExcluir.Enabled := False;
    btnSalvar.Enabled := False;
    btnAlterar.Enabled := False;
    btnCancelar.Enabled := False;
  end;

  btnSalvar.Enabled := False;
end;
procedure TFormCadProduto.PesquisaProdutoChange(Sender: TObject);
begin
  try
  dmCadProduto.pesquisaProduto(PesquisaProduto.text);
  except on E: Exception do
    Application.MessageBox(
      pchar('Erro ao Pesquisa, Messagem de erro:' + E.Message),        
       'Erro ao Pesquisa',MB_ICONERROR+MB_OK);                 
  end;          
end;       
end.
