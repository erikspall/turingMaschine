unit mainForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  Grids, ComCtrls, PairSplitter, Math, Lists;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ListBox1: TListBox;
    PageControl1: TPageControl;
    PairSplitter1: TPairSplitter;
    PairSplitterSide1: TPairSplitterSide;
    PairSplitterSide2: TPairSplitterSide;
    StatusBar1: TStatusBar;
    StringGrid1: TStringGrid;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Timer1: TTimer;
    ToolBar1: TToolBar;
    procedure Button1Click(Sender: TObject);
    procedure ControlBar1Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2EditingDone(Sender: TObject);
    procedure FormChangeBounds(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1ChangeBounds(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure moveForward();
    procedure Timer1Timer(Sender: TObject);
    procedure addPanelResize();
    procedure addPanel();
    procedure insertPanel();
    procedure removePanel();
    procedure FillPanelsWithContent();
  private

  public

  end;

var
  Form1: TForm1;
  band:TListofPanel;
  bandContent:TListofChar;
  i,pointer:Integer;
implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormResize(Sender: TObject);


begin


end;

procedure TForm1.FormShow(Sender: TObject);
var ttPanel: TPanel;
begin
   while (Form1.Width / 50)>band.Count() do
    begin
      ttPanel := TPanel.Create(Form1);
      ttPanel.Parent:=Form1;
      ttPanel.AnchorParallel(akBottom,StatusBar1.Height,StatusBar1);
     ttPanel.Anchors:=ttPanel.Anchors-[akTop];
      ttPanel.Top:=296-StatusBar1.Height;
      ttPanel.Height:=50;
      ttPanel.Width:=50;
      ttPanel.Left:=band.Count()*50;
      ttPanel.Caption:='#';


      band.Add(ttPanel);
      bandContent.Add('#');
    end;

    band.getItem(((band.count-1)div 2)-1).Color:=clDefault;
    pointer:=((band.count-1)div 2);
    band.getItem((band.count-1) div 2).Color:=Graphics.clHighlight;
end;

procedure TForm1.StringGrid1ChangeBounds(Sender: TObject);
begin
  Refresh();
end;

procedure TForm1.TabControl1Change(Sender: TObject);
begin

end;

procedure TForm1.moveForward();
begin
  Timer1.Enabled:=true;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  for i:=0 to band.Count()-1 do
  begin
    band.getItem(i).Left:=band.getItem(i).Left-4;
  end;
  Repaint();
   if band.getItem(0).Left = -50 then Timer1.Enabled:=false;
end;

procedure TForm1.addPanelResize();
Var ttPanel:TPanel;
begin

      ttPanel := TPanel.Create(Form1);
      ttPanel.Parent:=Form1;
      ttPanel.Top:=296-StatusBar1.Height;
      ttPanel.Height:=50;
      ttPanel.Width:=50;
      ttPanel.Caption:='#';
      ttPanel.AnchorParallel(akBottom,StatusBar1.Height,StatusBar1);
     ttPanel.Anchors:=ttPanel.Anchors-[akTop];

     if (frac(band.Count()/2)=0) then
      begin
         for i:=0 to band.count-1 do
         begin
           band.getItem(i).Left:=band.getItem(i).Left+50;
         end;
         if pointer-(band.Count() div 2)>=0 then
         ttPanel.Caption:=bandContent.getItem(pointer-(band.Count() div 2));
         ttPanel.Left:=0;
         band.insertItem(ttPanel,0);

         Label1.Caption:=pointer.toString;
         if bandContent.Count < band.Count then
          begin
         bandContent.insertItem('#',0);    Inc(pointer);
          end;
      end
      else
      begin



        ttPanel.Left:=band.count*50;
        if pointer+(band.Count() div 2)<bandContent.Count then
        ttPanel.Caption:=bandContent.getItem(pointer+(band.Count() div 2));
        band.Add(ttPanel);
        if bandContent.Count < band.Count then
        bandContent.Add('#');
      end;

end;

procedure TForm1.addPanel();
var ttPanel: TPanel;
begin

end;

procedure TForm1.insertPanel();
begin

end;

procedure TForm1.removePanel();
begin

end;

procedure TForm1.FillPanelsWithContent();
Var j:Integer;
begin
        if (frac(band.Count()/2)=0) then
      begin
        for i:=0 to band.Count()-1 do
        begin
             band.getItem(i).Caption:=bandContent.getItem(i+(pointer-(band.Count() div 2)+1));
         end;
         end else begin
           for i:=0 to band.Count()-1 do
        begin
             band.getItem(i).Caption:=bandContent.getItem(i+(pointer-(band.Count() div 2)));
         end;
         end;


end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('Band: ' + band.Count.toString + ' Content: ' + bandContent.Count().toString);
end;

procedure TForm1.ControlBar1Click(Sender: TObject);
begin

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2EditingDone(Sender: TObject);
var i:Integer;
begin
   for i:=1 to Length(Edit2.Text) do
   begin
     if i+pointer-1>=bandContent.Count then begin
       bandContent.Add(Edit2.Text[i]);
       bandContent.insertItem('#',0);
       inc(pointer); //not sure about this
       end else
     bandContent.replaceItem(i+pointer-1,Edit2.text[i]);
   end;
end;

procedure TForm1.FormChangeBounds(Sender: TObject);

begin
     if (Form1.Width / 50)>band.Count() then
    begin
    addPanelResize();

    end else if ((Form1.Width / 50)+1)<band.Count() then
    begin
      if not (frac(band.Count()/2)=0) then
      begin
        for i:=0 to band.count()-1 do
        begin
          band.getItem(i).Left:=band.getItem(i).Left-50;
        end;
        band.getItem(0).Destroy;

          Label1.Caption:=pointer.toString;
        band.deleteItemAt(0);
      end
      else
      begin
       band.getItem(band.Count()-1).Destroy;

       band.deleteItemAt(band.count-1);
      end;
      end;






        ListBox1.Clear;



    for i:=0 to bandContent.Count do
    begin
        ListBox1.Items.Add(bandContent.getItem(i));
     end;

    FillPanelsWithContent();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
   band:=TListOfPanel.Create;
   bandContent:=TListOfChar.Create;

end;


end.

