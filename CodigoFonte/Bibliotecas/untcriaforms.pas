unit untcriaforms;

{$mode ObjFPC}{$H+}

interface

uses
  Classes , SysUtils, ExtCtrls, Forms, Controls;
type

{ CriaForm }

 TCriaForm = class
  private
    FLista : TList;
    FTime : TTimer;
    procedure DoClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure TimeTimer(Sender: TObject);
  public
  constructor Create;
  destructor Destroy; override;
  procedure CreateForm(aFormClass : String; aParent :TWinControl = nil);
  end;

  Pitens = ^itens;
  itens = record
    data  : TDate;
    hora  : TTime;
    form  : TForm;
    close : Boolean;
  end;
implementation

{ CriaForm }

procedure TCriaForm.TimeTimer(Sender: TObject);
var
 i       : Integer;
 FItem   : Pitens;
 meuForm : TForm;
begin
 FTime.Enabled := False;
 i := FLista.Count -1;
 while i > -1  do
  begin
    FItem:= FLista[i];
    if FItem^.close = True then
       begin
         meuForm := FItem^.form;
         FreeAndNil(meuForm);
         Freemem(FItem);
         FLista.Delete(i);
         i := FLista.Count -1;
       end;
    Dec(i);
  end;

end;

procedure TCriaForm.DoClose(Sender: TObject; var CloseAction: TCloseAction);
var
    i      : Integer;
    FItem : Pitens;
begin
    for i := 0 to FLista.Count -1 do
    begin
      FItem:= FLista[i];
      if LowerCase( Sender.ClassName ) = LowerCase( FItem^.form.ClassName ) then
         FItem^.close := True;

    end;
    FTime.Enabled:= True;
    inherited;
end;

constructor TCriaForm.Create;
begin
  FLista := TList.Create;
  FTime  := TTimer.Create(Nil);

  with FTime do
  begin
    interval := 2000;
    onTimer  := @TimeTimer;
    Enabled  := False;
   end;

end;

destructor TCriaForm.Destroy;
var
  i      : Integer;
  FItem  : Pitens;
  meuForm: TForm;
begin
  FreeAndNil(FTime);
  for i := 0 to FLista.Count -1 do
    begin
      FItem := FLista[i];
      meuForm := FItem^.form;
      FreeAndNil(meuForm);
      Freemem(FItem);
    end;
  FreeAndNil(FLista);
  inherited Destroy;
end;

procedure TCriaForm.CreateForm(aFormClass: String; aParent: TWinControl = nil);
var
 FItem : Pitens;
 obj    : TComponentClass;
 i      : Integer;
begin
  for i := 0 to FLista.Count -1 do
  begin
      FItem:= FLista[i];
      if LowerCase( aFormClass ) = LowerCase( FItem^.form.ClassName ) then
         begin
           FItem^.form.BringToFront;
      end;
  end;
  new (FItem);
  FItem^.data := Date;
  FItem^.hora := Time;
  FItem^.close:= False;
  obj := TComponentClass(GetClass(aFormClass));
  try
    FItem^.form := obj.Create(Nil) as TForm;
    FItem^.form.ShowModal;
    FItem^.form.OnClose :=@DoClose;
      if aParent <> Nil then
         FItem^.form.Parent := aParent;
  except
    FreeAndNil(FItem);
    raise Exception.Create('A classe form não existe');
  end;
  FLista.Add(FItem);

end;


end.

