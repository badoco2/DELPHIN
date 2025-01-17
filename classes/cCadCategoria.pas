unit cCadCategoria;

interface
  uses System.Classes,
        Vcl.Controls,
        Vcl.ExtCtrls,
        Vcl.Dialogs,
        ZAbstractConnection,
        ZConnection,
        ZAbstractRODataset, ZAbstractDataset, ZDataset,
        System.SysUtils; //Lista de Units

Type
  TCategoria = class
    private
      ConexaoDB:TZConnection;
      F_categoriaID:Integer; //ID no banco
      F_descricao:String;
    function getCodigo: Integer;
    function getDescricao: string;
    procedure setCodigo(const Value: Integer);
    procedure setDescricao(const Value: string);  // descricao no Banco

    public
      constructor Create(aConexao:TZConnection);
      destructor Destroy; override;
      function Inserir:Boolean;
      function Atualizar:Boolean;
      function Apagar:Boolean;
      function Selecionar(id:integer):Boolean;
    published
      property codigo:Integer read getCodigo write setCodigo;
      property descricao:string read getDescricao write setDescricao;
  end;

implementation

{ TCategoria }
{$region 'Constructor Destructor CRUD'}

{$region 'CRUD'}

function TCategoria.Apagar: Boolean;
var Qry:TZQuery;
begin
  if MessageDlg('Apagar o Registro: '+#13+#13+
                'codgio: '+ IntToStr(F_categoriaID)+ #13+
                'Descri��o: ' + F_descricao,mtInformation,[mbYes, mbNo],0) = mrNo then
    begin
      Result:=false;
      abort;
    end;

    try
      Result:= True;
      Qry:=TZQuery.Create(nil);
      Qry.Connection:=ConexaoDB;
      Qry.SQL.Clear;
      Qry.SQL.Add('DELETE FROM categorias WHERE categoria_id = :categoria_id');
      Qry.ParamByName('categoria_id').AsInteger := F_categoriaId;
      TRY
        Qry.ExecSQL;
      FINALLY
        Result:=False;
      END;
    finally
      if Assigned(Qry) then
         FreeAndNil(Qry);
    end;
end;

function TCategoria.Atualizar: Boolean;
var Qry:TZQuery;
begin
      try
         Result:=true;
         Qry:=TZQuery.Create(nil)    ;
         Qry.Connection:=ConexaoDB;
         Qry.SQL.Clear;
         Qry.SQL.Add('UPDATE categorias SET descricao = :descricao WHERE categoria_id = :categoria_id ;' );
         Qry.ParamByName('categoria_id').AsInteger:=Self.F_categoriaID;
         Qry.ParamByName('descricao').AsString:=Self.F_descricao;  // da para usar o value no lugar do As String
         try
             Qry.ExecSQL;
         Except
             Result:=false;
         end;

      finally
          if Assigned(Qry) then
              FreeAndNil(Qry);
      end;
end;

function TCategoria.Inserir: Boolean;
var Qry:TZQuery;
begin
      try
         Result:=true;
         Qry:=TZQuery.Create(nil)    ;
         Qry.Connection:=ConexaoDB;
         Qry.SQL.Clear;
         Qry.SQL.Add('INSERT INTO categorias(descricao)Values (:descricao)' );
         Qry.ParamByName('descricao').AsString:=Self.F_descricao;  // da para usar o value no lugar do As String
         try
             Qry.ExecSQL;
         Except
             Result:=false;
         end;
         
      finally
          if Assigned(Qry) then
              FreeAndNil(Qry);
      end;
end;

function TCategoria.Selecionar(id: integer): Boolean;
var Qry:TZQuery;
begin
      try
         Result:=true; 
         Qry:=TZQuery.Create(nil)    ;
         Qry.Connection:=ConexaoDB;
         Qry.SQL.Clear;
         Qry.SQL.Add('SELECT categoria_id, descricao FROM categorias WHERE categoria_id= :categoria_id' );
         Qry.ParamByName('categoria_id').AsInteger:=id;
         try
             Qry.Open;

             Self.F_categoriaID := Qry.FieldByName('categoria_id').AsInteger;
             Self.F_descricao := Qry.FieldByName('descricao').AsString;
         Except
             Result:=false;
         end;

      finally
          if Assigned(Qry) then
              FreeAndNil(Qry);
      end;
end;
{$endregion}


{$region 'Constructor Destructor'}
constructor TCategoria.Create(aConexao:TZConnection);
begin
  ConexaoDB:=aConexao;
end;

destructor TCategoria.Destroy;
begin

  inherited;
end;

{$endregion}

{$endregion}

{$region 'Getters e Setters'}

function TCategoria.getCodigo: Integer;
begin
  Result:= Self.F_categoriaID;
end;

function TCategoria.getDescricao: string;
begin
  Result:= Self.F_descricao;
end;



procedure TCategoria.setCodigo(const Value: Integer);
begin
  Self.F_categoriaID := Value;
end;

procedure TCategoria.setDescricao(const Value: string);
begin
  Self.F_descricao:= Value;
end;
{$endregion}

end.
