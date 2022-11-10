CREATE DATABASE QLTiemGame;
GO

USE QLTiemgame;
GO

-- Nhập dữ liệu
CREATE TABLE TaiKhoan(
id INT IDENTITY(1,1) PRIMARY KEY, -- 1, 2,...
ma_tai_khoan VARCHAR(15) UNIQUE, --Tùy các bảng NV, KH, Admin
ten_dang_nhap VARCHAR(20) UNIQUE,
mat_khau VARCHAR(20),
ngay_tao_tai_khoan DATE, -- y-m-d
STATUS INT DEFAULT 0, -- 0
)
GO

--Nhập dữ liệu
CREATE TABLE Admin(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_tai_khoan VARCHAR(15) FOREIGN KEY REFERENCES TaiKhoan(ma_tai_khoan), --AD01....
ho_ten NVARCHAR(50)
)
GO

--Nhập dữ liệu
CREATE TABLE NhanVien(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_nhan_vien VARCHAR(15) UNIQUE FOREIGN KEY REFERENCES TaiKhoan(ma_tai_khoan) ON DELETE CASCADE, -- NV01...
ho_ten NVARCHAR(50),
ngay_sinh DATE,
gioi_tinh NVARCHAR(10), -- Nam, Nữ, Khác
so_dien_thoai CHAR(15),
dia_chi NVARCHAR(100),	
vai_tro NVARCHAR(20) -- Bảo vệ, Thu ngân,....
)
GO

-- Nhập dữ liệu
CREATE TABLE KhachHang(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_khach_hang VARCHAR(15) UNIQUE FOREIGN KEY REFERENCES TaiKhoan(ma_tai_khoan) ON DELETE CASCADE, --KH01...
so_phut_con_lai INT, -- 75
)
GO

--Nhập dữ liệu
CREATE TABLE LichSuNapTien(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_khach_hang VARCHAR(15) UNIQUE FOREIGN KEY REFERENCES KhachHang(ma_khach_hang) ON DELETE CASCADE,
ngay_nap DATETIME,
so_tien_nap INT,
)
GO

--Nhập dữ liệu
CREATE TABLE May(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_may VARCHAR(15) UNIQUE, --MAY01, ...
loai_may VARCHAR(10), --(VIP, Thường)
gia_tien_mot_gio INT, --thường: 5000, VIP: 10000
trang_thai NVARCHAR(10) -- Tắt Bật
)
GO


CREATE TABLE KhachHang_May(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_may VARCHAR(15) FOREIGN KEY REFERENCES May(ma_may),
ma_khach_hang VARCHAR(15) FOREIGN KEY REFERENCES KhachHang(ma_khach_hang) null,
thoi_gian_mo_may DATETIME,
)
GO

--Nhập dữ liệu
CREATE TABLE UuDai(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_uu_dai VARCHAR(15) UNIQUE, --ABCD0001
giam_gia INT NULL, --10000
qua_tang VARCHAR(50) NULL -- Sting, ...
)
GO

--Nhập dữ liệu
CREATE TABLE DichVu(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_dich_vu VARCHAR(15) UNIQUE, --TD01....
loai_dich_vu VARCHAR(50),
ten_mon NVARCHAR(50), -- Mì tôm
gia INT,
so_luong INT CHECK(so_luong >= 0)
)
GO

CREATE TABLE HoaDon(
ma_hoa_don VARCHAR(15) NOT NULL, -- = id trong KhachHang_May + ma_may
ma_dich_vu VARCHAR(15) FOREIGN KEY REFERENCES DichVu(ma_dich_vu) NULL,
ma_uu_dai VARCHAR(15) FOREIGN KEY REFERENCES UuDai(ma_uu_dai) NULL,
)
GO

CREATE TABLE DoanhThu(
id INT IDENTITY(1,1) PRIMARY KEY,
ma_hoa_don INT, -- = ma_hoa_don trong HoaDon nhung khong foreign key
ten_thu_ngan NVARCHAR(50),
ngay_thu DATETIME,
tong_tien_thu INT,
)
GO

-- MODIFY DATABASE
-- Add Column so_luong to HoaDon
ALTER TABLE HoaDon
ADD so_luong INT NULL
GO

-- Add Column luong-thang to NhanVien
ALTER TABLE NhanVien
ADD luong_thang INT NULL
GO

-- INSERT DATABASE

------------------------
-- TaiKhoan
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('Admin','Admin','12345678','2020-05-08')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('NV1','NV1','12345678','2020-06-19')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('NV2','NV2','12345678','2020-06-01')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('NV3','NV3','12345678','2020-06-15')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('KH1','KH1','12345678','2020-07-08')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('KH2','KH2','12345678','2020-07-16')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('KH3','KH3','12345678','2020-07-20')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('KH4','KH4','12345678','2020-07-15')
INSERT INTO TaiKhoan(ma_tai_khoan,ten_dang_nhap,mat_khau,ngay_tao_tai_khoan) VALUES('KH5','KH5','12345678','2020-07-09')


-- Admin
INSERT INTO Admin(ma_tai_khoan,ho_ten) VALUES('Admin','Nguyen Van A')

-- NhanVien
INSERT INTO NhanVien( ma_nhan_vien,ho_ten,ngay_sinh,gioi_tinh,so_dien_thoai,dia_chi,vai_tro ) VALUES('NV1',N'Nguyen Thi A','2002-06-04',N'Nữ','0352811529',N'TPHCM',N'Thu ngân')
INSERT INTO NhanVien( ma_nhan_vien,ho_ten,ngay_sinh,gioi_tinh,so_dien_thoai,dia_chi,vai_tro ) VALUES('NV2',N'Nguyen Van B','2002-06-04',N'Nam','0352811567',N'TPHCM',N'Bảo vệ')
INSERT INTO NhanVien( ma_nhan_vien,ho_ten,ngay_sinh,gioi_tinh,so_dien_thoai,dia_chi,vai_tro ) VALUES('NV3',N'Nguyen Thi C','2002-06-04',N'Nữ','0352815678',N'TPHCM',N'Lao công')

--KhachHang

INSERT INTO KhachHang(ma_khach_hang,so_phut_con_lai) VALUES('KH1',75)
INSERT INTO KhachHang(ma_khach_hang,so_phut_con_lai) VALUES('KH2',25)
INSERT INTO KhachHang(ma_khach_hang,so_phut_con_lai) VALUES('KH3',35)
INSERT INTO KhachHang(ma_khach_hang,so_phut_con_lai) VALUES('KH4',45)
INSERT INTO KhachHang(ma_khach_hang,so_phut_con_lai) VALUES('KH5',55)

-- LichSuNapTien
INSERT INTO LichSuNapTien(ma_khach_hang,ngay_nap,so_tien_nap) VALUES('KH1','2020-11-11 13:23:44',30000)
INSERT INTO LichSuNapTien(ma_khach_hang,ngay_nap,so_tien_nap) VALUES('KH2','2020-12-11 13:23:44',10000)
INSERT INTO LichSuNapTien(ma_khach_hang,ngay_nap,so_tien_nap) VALUES('KH3','2020-10-12 13:23:44',15000)
INSERT INTO LichSuNapTien(ma_khach_hang,ngay_nap,so_tien_nap) VALUES('KH4','2020-09-25 13:23:44',50000)
INSERT INTO LichSuNapTien(ma_khach_hang,ngay_nap,so_tien_nap) VALUES('KH5','2020-08-20 13:23:44',20000)

-- May
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY1','VIP',10000,N'Bật')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY2','Thường',5000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY3','Thường',5000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY4','VIP',10000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY5','Thường',5000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY6','Thường',5000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY7','Thường',5000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY8','VIP',10000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY9','VIP',10000,N'Tắt')
INSERT INTO May(ma_may,loai_may,gia_tien_mot_gio,trang_thai) VALUES('MAY10','VIP',10000,N'Tắt')

--KhachHang_May
INSERT INTO KhachHang_May(ma_may,ma_khach_hang,thoi_gian_mo_may) VALUES('MAY1','KH1','2020-11-11 13:23:44')


-- Uu dai
INSERT INTO UuDai(ma_uu_dai,giam_gia,qua_tang) VALUES('ABCD0001',5000,'Sting')
INSERT INTO UuDai(ma_uu_dai,giam_gia,qua_tang) VALUES('ABCD0002',10000,'Card')

--DichVu

INSERT INTO DichVu(ma_dich_vu,loai_dich_vu,ten_dich_vu,gia,so_luong) VALUES('TD1',N'Thức ăn',N'Mì tôm',5000,100)
INSERT INTO DichVu(ma_dich_vu,loai_dich_vu,ten_dich_vu,gia,so_luong) VALUES('TD2',N'Thức ăn',N'Trứng gà',5000,50)
INSERT INTO DichVu(ma_dich_vu,loai_dich_vu,ten_dich_vu,gia,so_luong) VALUES('TD3',N'Đồ uống',N'Sting',10000,50)
INSERT INTO DichVu(ma_dich_vu,loai_dich_vu,ten_dich_vu,gia,so_luong) VALUES('TD4',N'Đồ uống',N'Coca',10000,50)
INSERT INTO DichVu(ma_dich_vu,loai_dich_vu,ten_dich_vu,gia,so_luong) VALUES('TD5',N'Đồ uống',N'Pepsi',10000,50)
INSERT INTO DichVu(ma_dich_vu,loai_dich_vu,ten_dich_vu,gia,so_luong) VALUES('TD6',N'Đồ uống',N'Cafe',15000,50)
INSERT INTO DichVu(ma_dich_vu,loai_dich_vu,ten_dich_vu,gia,so_luong) VALUES('TD7',N'Thức ăn',N'Bánh mì ngọt',10000,30)

--HoaDon
INSERT INTO HoaDon(ma_hoa_don,ma_dich_vu,ma_uu_dai) VALUES(1,NULL,NULL)

--DoanhThu
INSERT INTO DoanhThu(ma_hoa_don,ten_thu_ngan,ngay_thu,tong_tien_thu) VALUES(1,'Nguyen Thi A','2020-11-11 15:23:44',20000)




-- PROCEDURE --

CREATE PROCEDURE proc_TinhTien @ma_hoa_don VARCHAR(15)
AS
	INSERT INTO HoaDon(ma_hoa_don)
	VALUES(@ma_hoa_don)
GO

CREATE PROCEDURE proc_TruTien @ma_khach_hang VARCHAR(15)
AS
	DECLARE @thoi_gian_mo_may DATETIME, @thoi_gian_su_dung DATETIME
	SET @thoi_gian_mo_may = (SELECT thoi_gian_mo_may FROM KhachHang_May WHERE ma_khach_hang = @ma_khach_hang)
	SET @thoi_gian_su_dung = (SELECT DATEDIFF(minute, @thoi_gian_mo_may, GETDATE()))
	DECLARE @so_phut_con_lai_old INT, @so_phut_con_lai_new INT
	SET @so_phut_con_lai_old = (SELECT so_phut_con_lai FROM KhachHang WHERE ma_khach_hang = @ma_khach_hang) 
	SET @so_phut_con_lai_new = @so_phut_con_lai_old - CONVERT(INT, @thoi_gian_su_dung)
	IF (@so_phut_con_lai_new < 0)
	BEGIN
		SET @so_phut_con_lai_new = 0
	END

	UPDATE KhachHang SET so_phut_con_lai = @so_phut_con_lai_new WHERE ma_khach_hang = @ma_khach_hang
GO
-- Hai proc trên phục vụ cho trigger TatMay. Không gọi trực tiếp trong C#

-- Khách hàng
-- Cách gọi trong C#: Statement: EXEC proc_ThemKhachHang @ten_dang_nhap = 'abc', @mat_khau = 'xyx'
CREATE PROCEDURE proc_ThemKhachHang @ten_dang_nhap VARCHAR(20), @mat_khau VARCHAR(20)
AS
	DECLARE @idMax INT, @ma_khach_hang VARCHAR(15)
	SET @idMax = (SELECT MAX(id) FROM KhachHang)
	SET @ma_khach_hang = 'KH' + CONVERT(VARCHAR, (@idMax + 1))

	INSERT INTO TaiKhoan(ma_tai_khoan, ten_dang_nhap, mat_khau, ngay_tao_tai_khoan)
	VALUES(@ma_khach_hang, @ten_dang_nhap, @mat_khau, FORMAT(GetDate(), 'yyyy-MM-dd'))
	INSERT INTO KhachHang(ma_khach_hang, so_phut_con_lai)
	VALUES(@ma_khach_hang, 0)
GO

CREATE PROCEDURE proc_ThayDoiMatKhauKhachHang @ten_dang_nhap VARCHAR(20), @mat_khau VARCHAR(20)
AS
	UPDATE TaiKhoan SET mat_khau = @mat_khau
	WHERE ten_dang_nhap = @ten_dang_nhap
GO

CREATE PROCEDURE proc_XoaKhachHang @ten_dang_nhap VARCHAR(20)
AS
	DELETE FROM TaiKhoan 
	WHERE ten_dang_nhap = @ten_dang_nhap
GO

CREATE PROCEDURE proc_NapTienKhachHang @ten_dang_nhap VARCHAR(20), @so_tien_nap INT
AS
	DECLARE @so_phut_nap INT, @gia_tren_gio INT, @ma_khach_hang VARCHAR(15)
	SET @gia_tren_gio = 5000
	SET @so_phut_nap = CONVERT(INT, (@so_tien_nap/@gia_tren_gio*60))
	SET @ma_khach_hang = (SELECT ma_tai_khoan FROM TaiKhoan WHERE ten_dang_nhap = @ten_dang_nhap)

	UPDATE KhachHang SET so_phut_con_lai = (so_phut_con_lai + @so_phut_nap)
	WHERE ma_khach_hang = @ma_khach_hang
GO

-- Nhân viên
CREATE PROCEDURE proc_ThemNhanVien 
	@ten_dang_nhap VARCHAR(20), 
	@mat_khau VARCHAR(20),
	@ho_ten NVARCHAR(50),
	@ngay_sinh DATE,
	@gioi_tinh NVARCHAR(10),
	@so_dien_thoai CHAR(15),
	@dia_chi NVARCHAR(100),
	@vai_tro NVARCHAR(20)
AS
	DECLARE @idMax INT, @ma_nhan_vien VARCHAR(15)
	SET @idMax = (SELECT MAX(id) FROM NhanVien)
	SET @ma_nhan_vien = 'NV' + CONVERT(VARCHAR, (@idMax + 1))

	INSERT INTO TaiKhoan(ma_tai_khoan, ten_dang_nhap, mat_khau, ngay_tao_tai_khoan)
	VALUES(@ma_nhan_vien, @ten_dang_nhap, @mat_khau, FORMAT(GetDate(), 'yyyy-MM-dd'))
	INSERT INTO NhanVien(ma_nhan_vien, ho_ten, ngay_sinh, gioi_tinh, so_dien_thoai, dia_chi, vai_tro)
	VALUES(@ma_nhan_vien, @ho_ten, @ngay_sinh, @gioi_tinh, @so_dien_thoai, @dia_chi, @vai_tro)
GO

CREATE PROCEDURE proc_SuaNhanVien 
	@ten_dang_nhap VARCHAR(20), 
	@mat_khau VARCHAR(20),
	@ho_ten NVARCHAR(50),
	@ngay_sinh DATE,
	@gioi_tinh NVARCHAR(10),
	@so_dien_thoai CHAR(15),
	@dia_chi NVARCHAR(100),
	@vai_tro NVARCHAR(20)
AS
	DECLARE @ma_nhan_vien VARCHAR(15)
	SET @ma_nhan_vien = (SELECT ma_tai_khoan FROM TaiKhoan WHERE ten_dang_nhap = @ten_dang_nhap)

	-- UPDATE Thông tin
	UPDATE NhanVien
	SET ho_ten = @ho_ten,
		ngay_sinh = @ngay_sinh,
		gioi_tinh = @gioi_tinh,
		so_dien_thoai = @so_dien_thoai,
		dia_chi = @dia_chi,
		vai_tro = @vai_tro
	WHERE ma_nhan_vien = @ma_nhan_vien
	UPDATE TaiKhoan
	SET ten_dang_nhap = @ten_dang_nhap,
		mat_khau = @mat_khau
	WHERE ma_tai_khoan = @ma_nhan_vien
GO

CREATE PROCEDURE proc_XoaNhanVien @ten_dang_nhap VARCHAR(20)
AS
	DELETE FROM TaiKhoan WHERE ten_dang_nhap = @ten_dang_nhap
GO

-- Máy
CREATE PROCEDURE proc_ThemMay @loai_may NVARCHAR(10)
AS
	DECLARE @idMax INT, @ma_may VARCHAR(15), @gia_tien INT
	SET @idMax = (SELECT MAX(id) FROM May)
	SET @ma_may = 'MAY' + CONVERT(VARCHAR, (@idMax + 1))
	IF (@loai_may = N'VIP')
	BEGIN
		SET @gia_tien = 8000
	END
	IF (@loai_may = N'Thường')
	BEGIN
		SET @gia_tien = 5000
	END

	INSERT INTO May(ma_may, loai_may, gia_tien_mot_gio, trang_thai)
	VALUES(@ma_may, @loai_may, @gia_tien, N'Tắt')
GO

CREATE PROCEDURE proc_SuaThongTinMay 
	@ma_may NVARCHAR(15),
	@loai_may NVARCHAR(10),
	@gia_tien_mot_gio INT
AS
	UPDATE May 
	SET loai_may = @loai_may, gia_tien_mot_gio = @gia_tien_mot_gio
	WHERE ma_may = @ma_may
GO

CREATE PROCEDURE proc_XoaMay @ma_may NVARCHAR(15)
AS
	DECLARE @trang_thai NVARCHAR(10)
	SET @trang_thai = (SELECT trang_thai FROM May WHERE ma_may = @ma_may)
	
	IF (@trang_thai = N'Tắt')
	BEGIN
		DELETE FROM May WHERE ma_may = @ma_may
	END
	ELSE
	BEGIN
		PRINT N'Vui lòng không sử dụng máy khi quyết định xóa'
	END
GO

CREATE PROCEDURE proc_ThemDichVuVaoHoaDon @ma_dich_vu VARCHAR(15), @so_luong_mua INT, @ma_hoa_don INT, @ma_uu_dai VARCHAR(15)
AS
	INSERT INTO HoaDon VALUES(@ma_hoa_don, @ma_dich_vu, @ma_uu_dai, @so_luong_mua)
GO

CREATE PROCEDURE proc_GiamSoLuongDichVu @ma_dich_vu VARCHAR(15), @so_luong_mua INT
AS
	UPDATE DichVu
	SET so_luong = so_luong - @so_luong_mua
	WHERE ma_dich_vu = @ma_dich_vu
GO


CREATE PROCEDURE proc_OrderDichVu @ma_dich_vu VARCHAR(15), @so_luong_mua INT, @ma_may VARCHAR(15), @ma_uu_dai VARCHAR(15) = NULL
AS
	BEGIN TRANSACTION
	BEGIN TRY
		DECLARE @check INT, @ma_hoa_don INT
		SET @check = dbo.KiemTraSoLuong(@ma_dich_vu, @so_luong_mua)
		SET @ma_hoa_don = (SELECT id FROM KhachHang_May WHERE ma_may = @ma_may)
		
		IF (@check = 1)
			BEGIN
				EXEC proc_ThemDichVuVaoHoaDon 
					@ma_dich_vu = @ma_dich_vu,
					@so_luong_mua = @so_luong_mua,
					@ma_hoa_don = @ma_hoa_don,
					@ma_uu_dai = @ma_uu_dai

				EXEC proc_GiamSoLuongDichVu @ma_dich_vu = @ma_dich_vu, @so_luong_mua = @so_luong_mua

			END
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK
	END CATCH
GO

CREATE PROCEDURE proc_MoMay @ma_may VARCHAR(15)
AS
	UPDATE May set trang_thai = N'Bật' where ma_may = @ma_may
GO

CREATE PROCEDURE proc_TatMay @ma_may VARCHAR(15)
AS
	UPDATE May set trang_thai = N'Tắt' where ma_may = @ma_may
GO

CREATE PROCEDURE proc_CapNhapKhachHangSuDung @ma_may VARCHAR(15), @ten_dang_nhap VARCHAR(20)
AS
	DECLARE @ma_tai_khoan VARCHAR(15)
	SET @ma_tai_khoan = (SELECT ma_tai_khoan FROM TaiKhoan WHERE ten_dang_nhap = @ten_dang_nhap)
	
	UPDATE KhachHang_May
	SET ma_khach_hang = @ma_tai_khoan
	WHERE ma_may = @ma_may
GO

-- Thực đơn


-- Ưu đãi



-- TRIGGER --
drop trigger trg_TatMay

CREATE TRIGGER trg_MoMay
ON May
AFTER UPDATE
AS
	IF UPDATE(trang_thai)
	BEGIN
		DECLARE @trang_thai_moi NVARCHAR(10), @trang_thai_cu NVARCHAR(10)
		SELECT @trang_thai_moi = new.trang_thai FROM INSERTED new
		SELECT @trang_thai_cu = old.trang_thai FROM DELETED old

		IF (@trang_thai_cu = N'Tắt' AND @trang_thai_moi = N'Bật')
			BEGIN
				DECLARE @ma_may VARCHAR(15), @ma_khach_hang VARCHAR(15)
				SELECT @ma_may = new.ma_may FROM INSERTED new
				SET @ma_khach_hang = NULL

				INSERT INTO KhachHang_May(ma_may, ma_khach_hang, thoi_gian_mo_may)
				VALUES(@ma_may, @ma_khach_hang, GETDATE())

				PRINT N'Mở máy thành công'
			END
	END
GO

CREATE TRIGGER trg_TatMay
ON May
AFTER UPDATE
AS
	IF UPDATE(trang_thai)
	BEGIN
		DECLARE @trang_thai_moi NVARCHAR(10), @trang_thai_cu NVARCHAR(10)
		SELECT @trang_thai_moi = new.trang_thai FROM INSERTED new
		SELECT @trang_thai_cu = old.trang_thai FROM DELETED old

		DECLARE @ma_may VARCHAR(15), @ma_hoa_don VARCHAR(15)
		SELECT @ma_may = new.ma_may FROM INSERTED new
		DECLARE @id INT, @ma_khach_hang VARCHAR(15)
		SET @id = (SELECT id FROM KhachHang_May WHERE ma_may = @ma_may)
		SET @ma_khach_hang = (SELECT ma_khach_hang FROM KhachHang_May WHERE ma_may = @ma_may)

		IF (@trang_thai_cu = N'Bật' AND @trang_thai_moi = N'Tắt')
		BEGIN
			IF (@ma_khach_hang is NULL)
				BEGIN
					EXEC proc_TinhTien @ma_hoa_don = @id

					PRINT N'Tắt máy thành công'
				END
			ELSE 
				BEGIN 
					EXEC proc_TruTien @ma_khach_hang = @ma_khach_hang
					DELETE FROM KhachHang_May WHERE ma_may = @ma_may

					PRINT N'Tắt máy thành công'
				END
		END
	END
GO


-- FUNCTION --
-- + Chức năng XemChiTiet Khác với View(XemDanhSach)

-- Cách gọi trong C#, Statement: SELECT * FROM XemThongTinKhachHang('Tên đăng nhập')
CREATE FUNCTION XemThongTinKhachHang(@ten_dang_nhap VARCHAR(20)) RETURNS TABLE
AS
	RETURN (SELECT KhachHang.ma_khach_hang, 
					TaiKhoan.ten_dang_nhap,
					KhachHang.so_phut_con_lai,
					TaiKhoan.ngay_tao_tai_khoan
			FROM KhachHang JOIN TaiKhoan 
				ON KhachHang.ma_khach_hang = TaiKhoan.ma_tai_khoan
			WHERE ten_dang_nhap = @ten_dang_nhap)
GO

CREATE FUNCTION XemLichSuNapTienKhachHang(@ten_dang_nhap VARCHAR(20)) RETURNS TABLE
AS
	RETURN (SELECT KhachHang.ma_khach_hang, 
					TaiKhoan.ten_dang_nhap,
					LichSuNapTien.ngay_nap,
					LichSuNapTien.so_tien_nap
			FROM KhachHang JOIN TaiKhoan ON KhachHang.ma_khach_hang = TaiKhoan.ma_tai_khoan
				JOIN LichSuNapTien ON KhachHang.ma_khach_hang = LichSuNapTien.ma_khach_hang
			WHERE ten_dang_nhap = @ten_dang_nhap)
GO

CREATE FUNCTION XemThongTinNhanVien(@ten_dang_nhap VARCHAR(20)) RETURNS TABLE
AS
	RETURN (SELECT NhanVien.ma_nhan_vien,
				NhanVien.ho_ten,
				NhanVien.gioi_tinh,
				NhanVien.ngay_sinh,
				NhanVien.so_dien_thoai,
				NhanVien.dia_chi,
				NhanVien.vai_tro,
				TaiKhoan.ten_dang_nhap,
				TaiKhoan.ngay_tao_tai_khoan
			FROM NhanVien JOIN TaiKhoan
				ON NhanVien.ma_nhan_vien = TaiKhoan.ma_tai_khoan
			WHERE ten_dang_nhap = @ten_dang_nhap)
GO

CREATE FUNCTION XemDoanhThuTheoNamVaThang(@name INT, @thang INT) RETURNS TABLE
AS
	RETURN (SELECT * 
			FROM DoanhThu
			WHERE YEAR(ngay_thu) = @name AND MONTH(ngay_thu) = @thang)
GO

CREATE FUNCTION CheckKhachHang(@ten_dang_nhap VARCHAR(20), @mat_khau VARCHAR(20)) RETURNS INT
AS
BEGIN
	RETURN (SELECT COUNT(*)
					FROM KhachHang JOIN TaiKhoan ON KhachHang.ma_khach_hang = TaiKhoan.ma_tai_khoan
					WHERE ten_dang_nhap = @ten_dang_nhap AND mat_khau = @mat_khau)
END
GO

CREATE FUNCTION SoPhutConLaiKhachHang(@ten_dang_nhap VARCHAR(20)) RETURNS INT
AS
BEGIN
	RETURN ( SELECT so_phut_con_lai 
				FROM TaiKhoan JOIN KhachHang ON KhachHang.ma_khach_hang = TaiKhoan.ma_tai_khoan
				WHERE ten_dang_nhap = @ten_dang_nhap
			)
END
GO

CREATE FUNCTION KiemTraSoLuong(@ma_dich_vu VARCHAR(15), @so_luong_mua INT) RETURNS INT
AS
BEGIN
	DECLARE @sl INT
	SET @sl = (SELECT so_luong FROM DichVu WHERE ma_dich_vu = @ma_dich_vu)
	IF (@sl > @so_luong_mua)
		RETURN 1
	RETURN 0
END
GO

-- VIEW --
-- Cách gọi trên C#, Statement: SELECT * FROM <VIEW_NAME>

CREATE VIEW XemDanhSachKhachHang AS
SELECT KhachHang.ma_khach_hang, 
		TaiKhoan.ten_dang_nhap,
		KhachHang.so_phut_con_lai,
		TaiKhoan.ngay_tao_tai_khoan
FROM KhachHang JOIN TaiKhoan 
	ON KhachHang.ma_khach_hang = TaiKhoan.ma_tai_khoan
GO

CREATE VIEW XemDanhSachNhanVien AS
SELECT NhanVien.ma_nhan_vien,
		NhanVien.ho_ten,
		NhanVien.gioi_tinh,
		NhanVien.ngay_sinh,
		NhanVien.so_dien_thoai,
		NhanVien.dia_chi,
		NhanVien.vai_tro,
		TaiKhoan.ten_dang_nhap,
		TaiKhoan.ngay_tao_tai_khoan
FROM NhanVien JOIN TaiKhoan
	ON NhanVien.ma_nhan_vien = TaiKhoan.ma_tai_khoan
GO

CREATE VIEW XemDanhSachMay AS
SELECT * 
FROM May
GO

CREATE VIEW XemDanhSachUuDai AS
SELECT *
FROM UuDai
GO

CREATE VIEW XemLichSuNapTien AS
SELECT * 
FROM LichSuNapTien
GO

CREATE VIEW XemDanhSachDichVu AS
SELECT * 
FROM DichVu
GO

CREATE VIEW XemDanhSachThucAn AS
SELECT * 
FROM DichVu
WHERE loai_dich_vu = N'Thức ăn'
GO

CREATE VIEW XemDanhSachNuocUong AS
SELECT * 
FROM DichVu
WHERE loai_dich_vu = N'Đồ uống'
GO

CREATE VIEW XemDanhSachTheGame AS
SELECT * 
FROM DichVu
WHERE loai_dich_vu = N'Thẻ game'
GO

CREATE VIEW XemDanhThu AS
SELECT * 
FROM DoanhThu
GO
