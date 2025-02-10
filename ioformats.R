library(stars)
here::here()
## Files saved with `xvec.encode_cf()`
## CF conventions and netCDF, Zarr in 
## https://github.com/martinfleis/xvec/blob/summary/doc/source/io.ipynb
## Function: https://github.com/martinfleis/xvec/blob/summary/xvec/accessor.py#L1343
fn_xvec_nc = "geo-encoded-xvec.nc"
fn_xvec_zr = "geo-encoded-xvec.zarr"

(nc = read_mdim(fn_xvec_nc))
## Reading the zarr file crashes R!
# (zr = read_mdim(fn_zr))

## Write with stars 
fn_stars_nc = "geo-encoded-stars.nc"
fn_stars_zr = "geo-encoded-stars.zarr"
write_mdim(nc, fn_stars_nc)
write_mdim(nc, fn_stars_zr)

## Check file structures
ncmeta::nc_meta(fn_xvec_nc)
ncmeta::nc_meta(fn_stars_nc)

fs::dir_tree(fn_xvec_zr)
fs::dir_tree(fn_stars_zr)

## Read back with stars
read_mdim(fn_stars_nc)
read_mdim(fn_stars_zr)



nc_inq(fn)
nc_dims(fn)
nc_atts(fn)
nc_meta(fn)
test1 = read_ncdf(fn)
test2 = read_mdim(fn)
st_crs(test1) = 4326
write_stars(test1, "data/raw/vdc-examples/geo-encoded-R.nc")
test3 = read_ncdf("data/raw/vdc-examples/geo-encoded-R.nc")
write_mdim(test2,  "data/raw/vdc-examples/geo-encoded-mdim.nc")
test4 = read_mdim("data/raw/vdc-examples/geo-encoded-mdim.nc")
test5 = read_mdim(fn_zr)
write_mdim(test5, "data/raw/vdc-examples/geo-encoded-mdim.zarr")
test6 = read_mdim("data/raw/vdc-examples/geo-encoded-mdim.zarr")
test5 |> st_as_sf()

library(post)
arr = as_post_array(polygons)
write_mdim(arr, "data/raw/vdc-examples/post_array.zarr")
arr_test = read_mdim("data/raw/vdc-examples/post_array.zarr")
nc_dims("data/raw/vdc-examples/geo-encoded-mdim.nc")


dir = here::here("data/raw/vdc-examples/")
set.seed(135)
m = matrix(runif(10), 2, 5)
names(dim(m)) = c("stations", "time")
times = as.Date("2022-05-01") + 1:5
pts = st_as_sfc(c("POINT(0 1)", "POINT(3 5)"))
s = st_as_stars(list(Precipitation = m)) |>
  st_set_dimensions(1, values = pts) |>
  st_set_dimensions(2, values = times)
write_mdim(s, here::here(dir, "random_test.nc"))
write_mdim(s, here::here(dir, "random_test.zarr"))
read_mdim(here::here(dir, "random_test.nc"))
read_mdim(here::here(dir, "random_test.zarr"))


arr = as_post_array(polygons, geometry_summary = summarise_geometry_bbox)
arr$area = st_area(arr$geometry)
arr$geometry = NULL
write_mdim(arr, here::here(dir, "dimension_geometry.nc"))
write_mdim(arr, here::here(dir, "dimension_geometry.zarr"))
read_mdim(here::here(dir, "dimension_geometry.nc"))
read_mdim(here::here(dir, "dimension_geometry.zarr"))


arr = as_post_array(polygons)
# arr$wkb = array(unclass(wk::as_wkb(arr$geometry)), dim = dim(arr))
arr$wkt = unclass(wk::as_wkt(arr$geometry))
arr$wkb = unclass(wk::as_wkb(arr$geometry))
arr$geometry = NULL
# arr$wkt = lwgeom::st_astext(arr$geometry)
# Crashes RStudio, apparently should not be called geometry because Zarr 
# has a property for vector dimensions called geometry
write_mdim(arr, here::here(dir, "test_wkt.zarr"), )
write_mdim(arr, here::here(dir, "test_wkb.zarr"), )
# Error: can only write one-dimensional character variables - NetCDF
write_mdim(arr, here::here(dir, "test_wkt.nc"))
read_mdim(here::here(dir, "test_wkt.zarr"))
read_mdim(here::here(dir, "test_wkt.nc"))

read_mdim(here::here(dir, "wkbcube.zarr"))

arr
st_as_binary(arr$geometry)
st_as_text(arr$geometry)

test7 = read_mdim("data/raw/vdc-examples/wkt.zarr/")
library(Rarr)
test8 = read_zarr_array("data/raw/vdc-examples/wkb.zarr")
library(zarrr)

read_mdim(here::here(dir, "glaciers.zarr"), debug = TRUE)


