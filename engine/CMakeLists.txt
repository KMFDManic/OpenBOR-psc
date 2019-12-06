cmake_minimum_required(VERSION 3.6)
project(OpenBOR)

set(CMAKE_CXX_STANDARD 11)


if( ${CMAKE_SYSTEM_PROCESSOR} STREQUAL "arm" )
	SET(CMAKE_C_FLAGS "-mfloat-abi=hard -march=armv8-a+simd -s -Os -O3")
	SET(CMAKE_CXX_FLAGS "-mfloat-abi=hard -march=armv8-a+simd -Os -O3")
	include_directories(/home/screemer/x-tools/armv8-sony-linux-gnueabihf/armv8-sony-linux-gnueabihf/sysroot/usr/include)
	link_directories(/home/screemer/x-tools/armv8-sony-linux-gnueabihf/armv8-sony-linux-gnueabihf/sysroot/usr/lib$)
else()

find_package(SDL2 REQUIRED)
include_directories(${SDL2_INCLUDE_DIRS})

	if( "${CMAKE_BUILD_TYPE}" STREQUAL "Debug" )
		if ( "$ENV{MEM_DEBUG}" STREQUAL "1" )
			message("Enabling additional memory debugging")
			SET(CMAKE_C_FLAGS "-fsanitize=address -fno-omit-frame-pointer")
			SET(CMAKE_CXX_FLAGS "-fsanitize=address -fno-omit-frame-pointer")
		endif()
	endif()
endif()

find_package(Threads REQUIRED)
add_definitions(-DSDL2 -DLINUX -DDEBUG -DSDL=1 -DOV_EXCLUDE_STATIC_CALLBACKS -DWEBM -DPSC )
 
add_executable(
        OpenBOR
        openbor.c
        sdl/joysticks.c
        openborscript.c
        sdl/control.c
        sdl/sblaster.c
        sdl/timer.c
        sdl/sdlport.c
        sdl/video.c
        sdl/videocommon.c
        sdl/threads.c
        sdl/menu.c
        source/adpcmlib/adpcm.c
        source/gfxlib/2xSaI.c
        source/gfxlib/bilinear.c
        source/gfxlib/dotmatrix.c
        source/gfxlib/gfx.c
        source/gfxlib/hq2x.c
        source/gfxlib/scale2x.c
        source/gfxlib/scanline.c
        source/gfxlib/simple2x.c
        source/gfxlib/tv2x.c
        source/gamelib/draw.c
        source/gamelib/draw32.c
        source/gamelib/draw16.c
        source/gamelib/font.c
        source/gamelib/translation.c
 source/gamelib/anigif.c
 source/gamelib/bitmap.c
 source/gamelib/screen.c
 source/gamelib/screen16.c
 source/gamelib/screen32.c
 source/gamelib/loadimg.c
 source/gamelib/palette.c
 source/gamelib/packfile.c
 source/gamelib/filecache.c
 source/gamelib/pixelformat.c
 source/gamelib/soundmix.c
 source/gamelib/spriteq.c
 source/gamelib/sprite.c
 source/gamelib/spritex8p16.c
 source/gamelib/spritex8p32.c
 source/gamelib/models.c
 source/gamelib/transform.c
 source/gamelib/filters.c
 source/stringptr.c
 source/utils.c
 source/stristr.c
 source/omath.c
 source/scriptlib/StackedSymbolTable.c
 source/scriptlib/ScriptVariant.c
 source/scriptlib/SymbolTable.c
 source/scriptlib/Instruction.c
 source/scriptlib/Interpreter.c
 source/scriptlib/ImportCache.c
 source/scriptlib/ParserSet.c
 source/scriptlib/Parser.c
 source/scriptlib/Lexer.c
 source/scriptlib/Stack.c
 source/scriptlib/List.c
 source/preprocessorlib/pp_lexer.c
 source/preprocessorlib/pp_parser.c
 source/preprocessorlib/pp_expr.c
 source/openborscript/commands.c
 source/openborscript/animation.c
 source/openborscript/axis.c
 source/openborscript/binding.c
 source/openborscript/drawmethod.c
 source/openborscript/collision_attack.c
 source/openborscript/collision_body.c
 source/openborscript/collision_entity.c
 source/openborscript/constants.c
 source/openborscript/entity.c
 source/openborscript/index.c
 source/openborscript/layer.c
 source/openborscript/level.c
 source/openborscript/recursive_damage.c
 source/openborscript/math.c
 source/openborscript/string.c
 source/ramlib/ram.c
 source/randlib/rand32.c
 source/pnglib/pngdec.c
 source/pnglib/savepng.c
 source/webmlib/vidplay.c
 source/webmlib/vorbis.c
 source/webmlib/samplecvt.c
 source/webmlib/yuv.c
 source/webmlib/halloc/halloc.c
  source/webmlib/nestegg/nestegg.c
)


target_include_directories(OpenBOR PUBLIC
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/sdl>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source>
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/sdl>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/adpcmlib>  
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/gamelib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/gfxlib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/openborscript>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/pnglib> 
   $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/preprocessorlib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/ramlib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/randlib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/scriptlib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/tracelib2>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/webmlib>
  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/source/resources>  
)
target_link_libraries(OpenBOR
         Threads::Threads
         SDL2
         SDL2_image
         SDL2_mixer
         SDL2_ttf
         png
         z
         m
         vorbis
         vorbisfile
         ogg
         vpx
         ${CMAKE_DL_LIBS}
)
add_custom_target(build-time-make-directory ALL
    COMMAND ${CMAKE_COMMAND} -E make_directory Logs
  COMMAND ${CMAKE_COMMAND} -E make_directory Packs
  COMMAND ${CMAKE_COMMAND} -E make_directory Saves
  COMMAND ${CMAKE_COMMAND} -E make_directory Screenshots
)
